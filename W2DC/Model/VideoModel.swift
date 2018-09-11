//
//  VideoModel.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import Foundation


struct VideoModel: Codable {
    var downloadUrl: String?
    var title: String
    var summary: String
    var streamUrl:String?
    var thumbnail:String?
}

