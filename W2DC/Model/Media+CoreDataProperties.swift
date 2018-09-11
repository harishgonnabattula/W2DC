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
        return NSFetchRequest<Media>(entityName: "MediaModel")
    }

    @NSManaged public var downloadUrl: String?
    @NSManaged public var streamUrl: String?
    @NSManaged public var summary: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}
