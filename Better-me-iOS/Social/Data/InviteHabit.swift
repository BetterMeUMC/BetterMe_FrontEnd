//
//  InviteHabit.swift
//  PlusAPI
//
//  Created by 황인성 on 2023/02/05.
//

import Foundation

struct InviteHabit: Codable, Hashable{
    var senderIdx: Int
    var receiverIdx: Int
    var habitIdx: Int
    var habitName: String
    var contents: String
    var emoge: String
}

struct InviteHabitResponse: Codable{
    var result: [InviteHabit]
    var isSuccess: Bool
    var code: Int
    var message: String
}
