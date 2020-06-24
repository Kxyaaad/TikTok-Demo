//
//  Comment.swift
//  TikTok
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Kxy. All rights reserved.
//

import Foundation

struct Comments: Codable {
    var comments: [Comment]
}

struct Comment:Codable {
    var text : String
    var digg_count : Int
    var creat_time : Int
    var user : User
    var reply_comment: [Comment]?
}


struct User: Codable {
    var nickname : String!
    var avatar_thumb : Avatar_thumb
}

struct Avatar_thumb: Codable {
    var url_list : [String]
}
