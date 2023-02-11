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
   
    
    func getNickNamePromise() {

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
                UserDefaults.standard.setValue(response.result.nickName, forKey: "nickName")
                UserDefaults.standard.setValue(response.result.promise, forKey: "promise")

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
                print("성공")
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
//    func judgeStatus(by statusCode: Int, _ data: User) -> NetworkResult<Any> {
//        
//        let decoder = JSONDecoder()
//        
//        guard let decodedData = try? decoder.decode(UserDataModel.self, from: data)
//        else { return .pathErr}
//        
//        switch statusCode {
//            
//        case 1000: return .success(decodedData.message)
//            //        case 2017: return .requestErr(decodedData.message)
//            //        case 500: return .serverErr
//        default: return .networkFail
//        }
//    }
}
            


