//
//  DownloadManager.swift
//  W2DC
//
//  Created by Ninja on 9/6/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation

class DownloadManager {
    
    private init() {}
    static let shared = DownloadManager()
    lazy var pendingDownloads = [IndexPath:Operation]()
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
        queue.name = "Video Download Queue"
        return queue
    }()
    
    func startDownload(item operation:DownloadOperation) {
        downloadQueue.addOperation(operation)
        
    }
}
