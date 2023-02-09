//
//  registerModel.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/24.
//

import Foundation

struct ResponseModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
