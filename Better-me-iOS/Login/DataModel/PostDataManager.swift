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
    
    func PostLogin(email: String, password: String, viewController: LoginFirstViewController) {
        let url = "http://54.180.13.219:3000/app/auth/login"
        
        let params = ["email": email, "password": password]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate()
            .responseDecodable(of: LoginModel.self) { response in
                switch response.result {
                case .success(let response):
             
                    if let jwt = response.result?.jwt {
                        viewController.loginCheck = true
                        viewController.performSegue(withIdentifier: "tabBar", sender: self)
          
                    } else {
                        print("토큰 없음")
                        viewController.alertLabel.isHidden = false
                        viewController.alertLabel.text = response.message
                        viewController.loginBtn.isEnabled = false
                        viewController.loginBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        viewController.loginBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                        viewController.loginCheck = false
                    }
                case .failure(let error):
                    print("서버오류")
                    print(error)
                }
                
            }
    }
    

    
    
}
