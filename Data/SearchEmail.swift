//
//  InviteHabit.swift
//  PlusAPI
//
//  Created by 황인성 on 2023/02/05.
//

import Foundation

struct SearchEmail: Codable, Hashable{
    var userIdx: Int
    var nickName: String
//    var photo: String
    var stars: Int
    var acceptStatus: Int
}

struct SearchEmailResponse: Codable{
    var result: [SearchEmail]
    var isSuccess: Bool
    var code: Int
    var message: String
}



