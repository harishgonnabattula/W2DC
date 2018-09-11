//
//  Media+CoreDataClass.swift
//  
//
//  Created by Ninja on 9/10/18.
//
//

import Foundation
import CoreData


public class Media: NSManagedObject, Codable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(downloadUrl, forKey: .downloadUrl)
        try container.encode(streamUrl, forKey: .streamUrl)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(title, forKey: .title)
        try container.encode(summary, forKey: .summary)
    }
    enum CodingKeys:String,CodingKey {
        case downloadUrl
        case streamUrl
        case thumbnail
        case title
        case summary
    }
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Media", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.downloadUrl = try container.decodeIfPresent(String.self, forKey: .downloadUrl)
            self.streamUrl = try container.decodeIfPresent(String.self, forKey: .streamUrl)
            self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
            self.title = try container.decodeIfPresent(String.self, forKey: .title)
            self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        }
        catch {}
        
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
