//
//  ResponseData.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/12.
//

import Foundation

// MARK: - Struct
struct getUserResponseStruct: Codable {
    let isSuccess: Bool
    let code: Int
    let message : String
    let result: User
}

struct patchUserResponseStruct: Codable {
    let message : String
    let code: Int
    let isSuccess: Bool
    
}

// MARK: - Person
struct User: Codable {
    let userIdx : Int
    let nickName : String
    let photo : String
    let promise : String
}

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
