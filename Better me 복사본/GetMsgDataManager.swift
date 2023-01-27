//
//  GetMsgData.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/25.
//

import Foundation
import Alamofire

struct GetMsgDataManager {
    func duplicateEmail(checkEmail: String, viewController: JoinViewController ) {
        let url = "http://54.180.13.219:3000/app/users/checkEmail?email=\(checkEmail)"
    
               AF.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type":"application/json", "Accept":"application/json"])
                   .validate()
                   .responseDecodable(of: ResponseModel.self) { response in
                       switch response.result {
                       case .success(let response):
                    
                           if response.code == 3001 { //이메일 중복인 경우
                               viewController.EmailDuplicateMsg = response.message
                               viewController.checkDuplicate = true
                           } else { //중복 아닌경우
                               viewController.checkDuplicate = false
                               print(response.message)
                           }
                           
                       case .failure(let error):
                           print("서버오류")
                           print(error)
                           viewController.checkDuplicate = false
                       }
                       
                   }
    }
    
}
