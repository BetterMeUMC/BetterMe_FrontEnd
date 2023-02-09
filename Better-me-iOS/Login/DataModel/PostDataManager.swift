//
//  PostDataManager.swift
//  Better me
//
//  Created by 심윤주 on 2023/01/25.
//

import Foundation
import Alamofire
import UIKit

struct PostDataManager {
    func PostUserData(email: String, password: String, nickName: String, promise: String, viewController: wordViewController) {
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
                           let pushVC = viewController.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
                           viewController.navigationController?.pushViewController(pushVC!, animated: true)
                           
                       case .failure(let error):
                           print("서버오류")
                           print(error)
                           let alert = UIAlertController(title: "알림", message: "서버가 불안정합니다. \n잠시후 시도해주세요.", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
                           })
                           viewController.present(alert, animated: true, completion: nil)
                        
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
                    let userIdx = response.result?.userID
                    UserDefaults.standard.set(userIdx, forKey: "userIdx")// 폴 : 유저 아이디를 위해 추가했습니다!
                    if let jwt = response.result?.jwt {
                        viewController.loginCheck = true
                      
                        let pushVC = viewController.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                        viewController.navigationController?.pushViewController(pushVC!, animated: true)
                        viewController.navigationController?.isNavigationBarHidden = true
                        UserDefaults.standard.set(jwt, forKey: "token")
                        GetMsgDataManager().autoLogin()

                    } else {
                        print(response.code)
                        
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
