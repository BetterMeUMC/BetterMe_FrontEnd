//
//  GetUserInxModel.swift
//  Better me
//
//  Created by 심윤주 on 2023/02/01.
//

import Foundation

struct GetUserIdxModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: UserIndex?
}

// MARK: - Result
struct UserIndex: Codable {
    let userIdx: Int
    let email, nickName: String
}
