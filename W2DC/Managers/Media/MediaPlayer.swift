//
//  MediaPlayer.swift
//  W2DC
//
//  Created by Ninja on 9/10/18.
//  Copyright © 2018 Ninja. All rights reserved.
//
import UIKit
import AVKit

class MediaPlayer {
    fileprivate var mediaUrl:URL!
    fileprivate var player:AVPlayer?
    lazy var playerLayer: AVPlayerLayer = {
        let p = AVPlayerLayer(player: self.player)
        p.videoGravity = .resizeAspectFill
        return p
    }()
    fileprivate var timeObserver: Any?
    private init() {}
    convenience init(mediaUrl:URL) {
        self.init()
        self.mediaUrl = mediaUrl
        self.player = AVPlayer(url: mediaUrl)
        NotificationCenter.default.addObserver(self, selector: #selector(MediaPlayer.playerDidFinishPlaying(note:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hasSuperlayer() -> Bool {
        return self.playerLayer.superlayer != nil
    }
    
    func adjustFrame(newFrame: CGRect){
        self.playerLayer.frame = newFrame
    }
    
    func addTimeObserver(observerHandler:@escaping (Int,String,CMTime) -> Void){
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: nil, using: { [weak self] (cmtime) in
            guard let _ = self else { return }
            let timeNow = Int(CMTimeGetSeconds((self?.player?.currentItem?.duration)!)) - Int(CMTimeGetSeconds(cmtime))
            let duration: String = "\(timeNow / 60):\(timeNow % 60)"
            observerHandler(timeNow,duration,cmtime)
        })
    }
    
    func toggleVideoState() {
        if self.player?.timeControlStatus == .playing{
            self.player?.pause()
        }
        else{
            self.player?.play()
        }
    }
    
    func removePlayer(completion: () -> Void) {
        if let _ = timeObserver {
            self.player?.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
        player = nil
        playerLayer.removeFromSuperlayer()
        completion()
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        player?.seek(to: CMTimeMake(0, 1000))
    }
    
    func getCopyOfPlayer() -> AVPlayer {
        guard let _ = self.player else {
            return AVPlayer()
        }
        let player = AVPlayer(url: mediaUrl)
        player.seek(to: self.player!.currentTime(), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        return player
    }
}
