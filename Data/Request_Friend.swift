//
//  Request_Friend.swift
//  PlusAPI
//
//  Created by 황인성 on 2023/02/04.
//

import Foundation

struct RequestFriend: Codable, Hashable{
    var userIdx: Int
    var nickName: String
//    var photo: String
}

struct RequestFriendResponse: Codable{
    var result: [RequestFriend]
    var isSuccess: Bool
    var code: Int
    var message: String
}



