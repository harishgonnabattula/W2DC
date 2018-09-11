//
//  VideoViewModel.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation

enum DownloadStatus: String,Codable {
    case Completed
    case Paused
    case NotDownloaded
}

struct VideoViewModel {
    
    fileprivate var video: VideoModel!
    fileprivate var isDownloaded = false {
        didSet{
            status = isDownloaded ? .Completed : .NotDownloaded
        }
    }
    fileprivate var localPath:String?
    
    var url: URL {
        return isDownloaded ? URL(fileURLWithPath: localPath!) : URL(string: video.streamUrl!)!
    }
    var status = DownloadStatus.NotDownloaded
    var title: String {
        return video.title
    }
    var summary: String {
            return video.summary
    }
    var videoThumbnail: URL {
        return URL(string:video.thumbnail!)!
    }
    init(with video: VideoModel) {
        self.video = video
    }

    //TODO: Function Skeletons
//    func setVideoFavourite(value: Bool) {
//        self.video.isFavourited = value
//    }
//
//    func fetchVideoFromServer() {
//
//    }
}
