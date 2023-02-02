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
                           print(error)
                           viewController.serverCheck = true
                       }
                       
                   }
    }
    
    func checkIdx(userEmail: String) {
        let url = "http://54.180.13.219:3000/app/users/get/\(userEmail)"
    
               AF.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type":"application/json", "Accept":"application/json"])
                   .validate()
                   .responseDecodable(of: GetUserIdxModel.self) { response in
                       switch response.result {
                       case .success(let response):
                    
                           if let userIdx = response.result?.userIdx {
                               print(userIdx)
                      
                               sendedPwd(userIdx: userIdx, email: userEmail)
                           } else {
                               print("값 없음")
                           }
                           
                       case .failure(let error):
                           print(error)
                     
                       }
                       
                   }
    }
    
    func sendedPwd(userIdx: Int, email: String) {
        let url = "http://54.180.13.219:3000/app/users/issuedPw/\(userIdx)"
        
        let params = ["userEmail": email] as Dictionary
        
        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate()
            .responseDecodable(of: ResponseModel.self) { response in
                switch response.result {
                case .success(let response):
             
                    print(response.code) //토큰이 필요하다고 뜸.
                    print(response.message)
                    
                case .failure(let error):
                    print(error)
              
                }
                
            }
    }
}
