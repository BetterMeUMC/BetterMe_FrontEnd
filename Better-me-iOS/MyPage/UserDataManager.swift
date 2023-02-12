//
//  GetPersonDataService.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/05.
//

import Foundation
import Alamofire
import UIKit


class UserDataManager { 
    
    let token = UserDefaults.standard.string(forKey: "token")
    let userIdx = UserDefaults.standard.string(forKey: "userIdx")
   
    
    func getUserInfoData() {

        guard let url = URL(string: "http://54.180.13.219:3000/app/users/getMyPage/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: getUserResponseStruct.self) { response in
            switch response.result {
            case .success(let response):
                print(response.result.nickName)
                print(response.result.promise)
                print(response.result.photo)
                UserDefaults.standard.setValue(response.result.nickName, forKey: "nickName")
                UserDefaults.standard.setValue(response.result.promise, forKey: "promise")
               
                let photoURL = URL(string: response.result.photo)
                UserDefaults.standard.setValue(photoURL, forKey: "photoURL")
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func patchUserData(nickName: String, promise: String, viewController: ProfileEditController) {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/users/changeN/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]
        let params = ["nickName": nickName] as Dictionary
        
        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(_):
                
                self.patchPromise(promise: promise,viewController: viewController)
                UserDefaults.standard.setValue(nickName, forKey: "nickName")
                UserDefaults.standard.setValue(promise, forKey: "promise")
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func patchPromise(promise: String, viewController: ProfileEditController) {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/users/changePm/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]
        let params = ["promise": promise] as Dictionary
        
        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(_):
                
                let alret = UIAlertController(title: "저장!", message: "프로필이 수정되었습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alret.addAction(ok)
                viewController.present(alret, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func patchPassword(password: String, viewController: PWEditController) {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/users/changePw/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]
        let params = ["password": password] as Dictionary
        
        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(_):
                
                let alret = UIAlertController(title: "비밀번호 변경완료!", message: "비밀번호가 변경되었습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alret.addAction(ok)
                viewController.present(alret, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func deleteAccount(viewController: WithdrawalViewController) {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/auth/unregister/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["x-access-token": token ?? ""]
        
        AF.request(url,
                   method: .delete,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(_):
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                            UserDefaults.standard.removeObject(forKey: key.description)
                        }
                let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
                viewController.view.window?.rootViewController = mainController
                viewController.view.window?.makeKeyAndVisible()
                print("회원탈퇴 완료")
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
}



