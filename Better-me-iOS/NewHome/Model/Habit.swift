//
//  Habit.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import Foundation

struct Habit {
    var hNum: Int
    var isCheck: Bool
    var date: Date
    var emoji: String
    var title: String
    var category : String
    var contents: String
    var period:[Int] = Array<Int>(repeating: -1, count: 7)
    var shared: Bool
    var with:[Person]
    // var theme: Theme
}
