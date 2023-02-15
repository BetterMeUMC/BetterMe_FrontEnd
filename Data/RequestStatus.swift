//
//  RandomUser+ResponseData.swift
//  Server
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation

struct RequestStatus: Codable, Hashable{
    
    
//    var id = UUID()
    var habitIdx: Int
    var receiverIdx: Int
    var status: String
    
}





struct RequestStatusResponse: Codable{
    
    var result: [RequestStatus]
    var isSuccess: Bool
    var code: Int
    var message: String

}



