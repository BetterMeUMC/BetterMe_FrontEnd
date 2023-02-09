//
//  Person.swift
//  BetterMe-SwiftUI
//
//  Created by 황인성 on 2023/01/12.
//

import Foundation

struct Person: Identifiable{
    
    var id = UUID()
    var name = ""
    var online = false
    var like = 0
    var habit = "습관 없음"
    
}
