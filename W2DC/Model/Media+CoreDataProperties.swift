//
//  Media+CoreDataProperties.swift
//  
//
//  Created by Ninja on 9/10/18.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        let fetchRequest = NSFetchRequest<Media>(entityName: "MediaModel")
        fetchRequest.predicate = NSPredicate(format: "streamUrl.length > 0")
        return fetchRequest
    }

    @NSManaged public var downloadUrl: String?
    @NSManaged public var streamUrl: String?
    @NSManaged public var summary: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var favourite: Bool

}
