//
//  DownloadOperation.swift
//  W2DC
//
//  Created by Ninja on 9/12/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation


class DownloadOperation : Operation {
    var media: VideoViewModel
    var _executing = true
    var _finished = false
    init(_ media: VideoViewModel) {
        self.media = media
    }
    
    override var isFinished: Bool{
        return _finished
    }
    override var isExecuting: Bool{
        return _executing
    }
    
    override func start() {
        if isCancelled {
            return
        }
        _executing = true
        _finished = false
        let url = media.downloadUrl
        
        let task = URLSession.shared.downloadTask(with: url) { (localUrl, response, error) in
            if(error == nil){
                let destinationURL = self.localFilePath(for: self.media.downloadUrl)
                print(destinationURL)
                // 3
                let fileManager = FileManager.default
                try? fileManager.removeItem(at: destinationURL)
                do {
                    try fileManager.copyItem(at: localUrl!, to: destinationURL)
                    self.media.localPath = destinationURL.lastPathComponent
                } catch let error {
                    print("Could not copy file to disk: \(error.localizedDescription)")
                }
            }
            else{
                print("Failed to download")
            }
            self.completionBlock!()
            self._executing = false
            self._finished = true
        }
        task.resume()
        
        if isCancelled {
            return
        }
    }
    override var isAsynchronous: Bool {
        return true
    }
    
    func localFilePath(for url: URL) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsPath.appendingPathComponent(url.lastPathComponent)
        
    }
}

//For an async operation like URLTasks use start isAsync,exec and finish. Otherwise use main function
