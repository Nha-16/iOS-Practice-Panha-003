//
//  PostModel.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import Foundation
import SwiftyJSON

struct Post {
    let id: Int
    let caption: String
    let image: String
    let numberOfLikes: Int
    let userId: Int
    let username: String
    let owner: Bool
    
    init(json: JSON){
        self.id = json["id"].intValue
        self.caption = json["caption"].stringValue
        self.image = json["image"].stringValue
        self.numberOfLikes = json["numberOfLikes"].intValue
        self.userId = json["userId"].intValue
        self.username = json["username"].stringValue
        self.owner = json["owner"].boolValue
    }
    
}
