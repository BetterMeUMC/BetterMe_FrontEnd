//
//  LoginModel.swift
//  Better me
//
//  Created by 심윤주 on 2023/02/01.
//

import Foundation

struct LoginModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let userID: Int
    let jwt: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case jwt
    }
}
