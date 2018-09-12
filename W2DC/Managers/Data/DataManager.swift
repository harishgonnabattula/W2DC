//
//  DataManager.swift
//  W2DC
//
//  Created by Ninja on 9/12/18.
//  Copyright © 2018 Ninja. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    fileprivate let fetchResultsController = (UIApplication.shared.delegate as! AppDelegate).fetchedResultsController
    
    weak var videoTableViewController: ViewController? {
        didSet{
            self.fetchResultsController.delegate = videoTableViewController
        }
    }
    
    func getFavouriteCount() -> Int {
        let predicate = NSPredicate(format: "favourite==1")
        fetchResultsController.fetchRequest.predicate = predicate
        do {
            try self.fetchResultsController.performFetch()
            return fetchResultsController.fetchedObjects!.count
        }
        catch _ {
            print("Error")
            return 0
        }
    }
    
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
    
    func updateObject(with ID: NSManagedObjectID, favourite:Bool) {
        let object = context.object(with: ID) as! Media
        object.favourite = favourite
        do {
            try context.save()
        }
        catch _ {
            print("Didnt save")
        }
    }
    
    func download(Url: URL) {
        
    }
}
