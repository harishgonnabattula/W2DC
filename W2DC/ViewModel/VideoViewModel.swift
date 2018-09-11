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
    fileprivate let fetchResultsController = (UIApplication.shared.delegate as! AppDelegate).fetchedResultsController
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
    private init(with video: Media) {
        self.video = video
    }
    
    init() {}
    
    func mediaItems() -> [VideoViewModel] {
        do{
            try fetchResultsController.performFetch()
            if fetchResultsController.fetchedObjects!.count == 0 {
                DataFromJSON.shared.loadVideos()
                try fetchResultsController.performFetch()
            }
            return fetchResultsController.fetchedObjects!.map({ (media) -> VideoViewModel in
                VideoViewModel(with: media)
            })
        }
        catch _ {
            print("Error performing fetch")
            return []
        }
    }
    
    func filterItems(with query:String) -> [VideoViewModel] {
        if(query != "")
        {
            self.fetchResultsController.fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@",query)
        }
        do {
            try self.fetchResultsController.performFetch()
            return fetchResultsController.fetchedObjects!.map({ (media) -> VideoViewModel in
                VideoViewModel(with: media)
            })
        }
        catch _ {
            print("Error")
            return []
        }
    }
}

