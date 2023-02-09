//
//  InviteHabit.swift
//  PlusAPI
//
//  Created by 황인성 on 2023/02/05.
//

import Foundation

struct SearchName: Codable, Hashable{
    var followee: Int
    var nickName: String
//    var photo: String
    var stars: Int
}

struct SearchNameResponse: Codable{
    var result: [SearchName]
    var isSuccess: Bool
    var code: Int
    var message: String
}



