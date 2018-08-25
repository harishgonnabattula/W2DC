//
//  DataFromJSON.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation

class DataFromJSON {
    
    static let shared = DataFromJSON()
    
    lazy var videos: [VideoViewModel] = {
        do{
            let path = Bundle.main.path(forResource: "wwdc", ofType: "json")
            let fileURL = URL(fileURLWithPath: path!)
            let jsonData = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            
            let model = try jsonDecoder.decode([VideoModel].self, from: jsonData)
            return model.map({ (vmodel) -> VideoViewModel in
                VideoViewModel(with: vmodel)
            })
        }
        catch {
            print("Error")
            return []
        }
    }()
}
