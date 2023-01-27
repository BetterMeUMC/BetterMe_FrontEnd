//
//  PostDataManager.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/25.
//

import Foundation
import Alamofire

struct PostDataManager {
    func PostUserData(email: String, password: String, nickName: String, promise: String) {
        let url = "http://54.180.13.219:3000/app/auth/register"
    
        let params = ["email": email, "password": password, "nickName": nickName, "promise": promise] as Dictionary
    
               AF.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type":"application/json", "Accept":"application/json"])
                   .validate()
                   .responseDecodable(of: ResponseModel.self) { response in
                       switch response.result {
                       case .success(let response):
                    
                           print(response.message)
                           
                       case .failure(let error):
                           print("서버오류")
                           print(error)
                        
                       }
                       
                   }
    }
}
