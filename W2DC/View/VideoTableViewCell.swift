//
//  VideoTableViewCell.swift
//  W2DC
//
//  Created by Ninja on 9/6/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import UIKit
import AVKit
import Kingfisher
import FaveButton
import CoreData

protocol FullScreenVideoDelegate:class {
    func presentVideoInFullScreen(player:AVPlayer);
    func reloadCell(cell:VideoTableViewCell);
}
class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteButton: FaveButton!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    weak var fullScreenDelegate:FullScreenVideoDelegate?
    fileprivate var timeObserver:Any?
    fileprivate var isPaused = true
    fileprivate var mediaPlayer: MediaPlayer?
    fileprivate var mediaModel:VideoViewModel!
    fileprivate var summary = "" {
        didSet{
            guard let summaryLabl = summaryLabel else{
                return
            }
            summaryLabl.attributedText = NSAttributedString(string: summary)
        }
    }
    fileprivate var timer = "" {
        didSet{
            guard let timeLbl = timeLabel else{
                return
            }
            timeLbl.text = timer
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(VideoTableViewCell.initializePlayer(sender:)))
        thumbnailImage.addGestureRecognizer(tapGesture)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(VideoTableViewCell.expandCell(sender:)))
        summaryLabel.addGestureRecognizer(tapGesture1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with mediaModel: VideoViewModel) {
        self.mediaModel = mediaModel
        thumbnailImage.kf.setImage(with: mediaModel.videoThumbnail)
        self.summary = mediaModel.summary
        summaryLabel.collapseLabel(with: summary)
    }
    
    @objc func initializePlayer(sender: UITapGestureRecognizer) {
        if mediaPlayer == nil {
            mediaPlayer = MediaPlayer(mediaUrl: self.mediaModel.url)
        }
        addPlayer()
    }
    @objc func expandCell(sender: UITapGestureRecognizer) {
        fullScreenDelegate?.reloadCell(cell: self)
    }
    
    @IBAction func showFullScreen(_ sender: Any) {
        guard let mPlayer = mediaPlayer else {
            return
        }
        let tempPlayer = mPlayer.getCopyOfPlayer()
        removePlayerFromView()
        self.fullScreenDelegate?.presentVideoInFullScreen(player: tempPlayer)
    }
    fileprivate func addPlayer() {
        guard let mPlayer = mediaPlayer else {
            return
        }
        if !mPlayer.hasSuperlayer(){
            mPlayer.adjustFrame(newFrame: thumbnailImage.bounds)
            mPlayer.addTimeObserver { (time, duration, cmTime) in
                DispatchQueue.main.async {
                    self.timer = duration
                }
            }
            thumbnailImage.layer.addSublayer(mPlayer.playerLayer)
        }
        mPlayer.toggleVideoState()
    }
    func removePlayerFromView() {
        guard let mPlayer = mediaPlayer else {
            return
        }
        mPlayer.removePlayer {
            mediaPlayer = nil
        }
        
    }
    
    @IBAction func setFavourite(_ sender: FaveButton) {
        mediaModel.markVideoAsFavourite(flag: sender.isSelected)
    }
    
    @IBAction func downloadThisVideo() {
        mediaModel.downloadVideo()
    }
    
}
