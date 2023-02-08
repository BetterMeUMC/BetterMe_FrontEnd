//
//  UserDataModel.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/22.
//

import Foundation

class UserInfo {
    private init() { }
    static let shared = UserInfo()
    
    var email: String?
    var password: String?
    var nickName: String?
    var promise: String?
}
