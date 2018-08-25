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
    
    var url: URL {
        get {
            return isDownloaded ? URL(fileURLWithPath: localPath!) : URL(string: video.urlString)!
        }
    }
    var status = DownloadStatus.NotDownloaded
    
    fileprivate var isDownloaded = false {
        didSet{
            status = isDownloaded ? .Completed : .NotDownloaded
        }
    }
    fileprivate var localPath:String?
    
    var title: String {
        get{
            return video.title
        }
    }
    var summary: String {
        get{
            return video.summary
        }
    }
    
    init(with video: VideoModel) {
        self.video = video
    }
    
    func getVideo() -> Data? {
        do{
            return try Data(contentsOf: url)
        }
        catch {
            print("Error fetch video data")
            return nil
        }
    }
    
    //MARK:- Future Release
    
//    func downloadVideo() {
//
//    }
}
