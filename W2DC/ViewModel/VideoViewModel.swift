//
//  VideoViewModel.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum DownloadStatus: String,Codable {
    case Completed
    case InProgress
    case Paused
    case NotDownloaded
}

struct VideoViewModel {
    
    fileprivate var video: Media!
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
        return video.title!
    }
    var summary: String {
            return video.summary!
    }
    var videoThumbnail: URL {
        return URL(string:video.thumbnail!)!
    }
    var isFavourite: Bool {
        return video.favourite
    }
    
    init(with video: Media) {
        self.video = video
    }
    
    func markVideoAsFavourite(flag: Bool) {
        DataManager.shared.updateObject(with: video.objectID, favourite: flag)
    }
    
    mutating func downloadVideo() {
        status = .InProgress
        DataManager.shared.download(Url: url)
    }
}

