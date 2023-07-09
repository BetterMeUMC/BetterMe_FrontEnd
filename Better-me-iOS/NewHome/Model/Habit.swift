//
//  Habit.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import Foundation
import EmojiPicker

struct Habit: Identifiable {
    let id : UUID
    var hNum: Int
    var isCheck: Bool
    var date: Date
    var emoji: Emoji
    var title: String
    var category : String
    var contents: String
    var period:[Int] = Array<Int>(repeating: -1, count: 7)
    var isPublic: Bool
    var with:[Person]
}
