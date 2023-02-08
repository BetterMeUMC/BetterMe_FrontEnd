//
//  RandomUser+ResponseData.swift
//  Server
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation

struct FriendSearch: Codable, Hashable{
    
    
//    var id = UUID()
    var followee: Int
    var nickName: String
//    var photo: String
    var stars: Int
    
}




struct FriendSearchResponse: Codable{
    
    var result: [FriendSearch]
    var isSuccess: Bool
    var code: Int
    var message: String

}


