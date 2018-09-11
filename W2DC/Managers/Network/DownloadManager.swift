//
//  DownloadManager.swift
//  W2DC
//
//  Created by Ninja on 9/6/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation

struct DownloadManager {
    lazy var pendingDownloads = [IndexPath:Operation]()
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Video Download Queue"
        return queue
    }()
    func startDownload(item video:VideoViewModel) {
    }
}
