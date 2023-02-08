//
//  RandomUser+ResponseData.swift
//  Server
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation

struct Priend: Codable, Hashable{
    
    
//    var id = UUID()
    var followee: Int
    var nickName: String
//    var photo: String
    var promise: String
    var acceptedAt: String
    var stars: Int
    
}





struct FriendResponse: Codable{
    
    var result: [Priend]
    var isSuccess: Bool
    var code: Int
    var message: String

}


