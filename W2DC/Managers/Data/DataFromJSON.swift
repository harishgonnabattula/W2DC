//
//  DataFromJSON.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation
import UIKit


class DataFromJSON {
    
    static let shared = DataFromJSON()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadVideos() {
        do{
            let path = Bundle.main.path(forResource: "wwdc", ofType: "json")
            let fileURL = URL(fileURLWithPath: path!)
            let jsonData = try Data(contentsOf: fileURL)
            let context = appDelegate.persistentContainer.newBackgroundContext()
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo[CodingUserInfoKey.context!] = context
            _ = try jsonDecoder.decode([Media].self, from: jsonData)
            try context.save()
        }
        catch {
            print("Error")
        }
    }
}
