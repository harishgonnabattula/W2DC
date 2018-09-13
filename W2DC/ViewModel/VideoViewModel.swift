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

class VideoViewModel {
    
    fileprivate var video: Media!
    var localPath:String?
    var url: URL {
        if let lp = localPath {
            let fm = FileManager.default
            let docsurl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myurl = docsurl.appendingPathComponent(lp)
            return myurl
        }
        return URL(string: video.streamUrl!)!
    }
    //var status = DownloadStatus.NotDownloaded
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
    var downloadUrl: URL {
        return URL(string: video.downloadUrl!)!
    }
    
    init(with video: Media) {
        self.video = video
        localPath = video.localPath
    }
    
    func markVideoAsFavourite(flag: Bool) {
        DataManager.shared.updateObject(with: video.objectID, using: "localPath", and: "s")
    }
    
    func downloadVideo() {
        let operation = DownloadOperation.init(self)
        operation.completionBlock = { [weak self] in
            guard let _ = self else { return }
            if operation.isCancelled { return }
            DispatchQueue.main.async {
                DataManager.shared.updateObject(with: self!.video.objectID, using: "localPath", and: self?.localPath)
            }
        }
        DownloadManager.shared.startDownload(item: operation)
    }
}

