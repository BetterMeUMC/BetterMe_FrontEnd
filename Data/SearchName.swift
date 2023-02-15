//
//  InviteHabit.swift
//  PlusAPI
//
//  Created by 황인성 on 2023/02/05.
//

import Foundation

struct SearchName: Codable, Hashable{
    let followee: Int
    let nickName: String
//    var photo: String
    let stars: Int
}

struct SearchNameResponse: Codable{
    let isSuccess: Bool
    let result: [SearchName]
    let code: Int
    let message: String
}



