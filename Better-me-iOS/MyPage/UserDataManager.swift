//
//  GetPersonDataService.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/05.
//

import Foundation
import Alamofire


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
        .responseDecodable(of: UserDataModel.self) { response in
            switch response.result {
            case .success(let response):
                UserDefaults.standard.setValue(response.result.nickName, forKey: "nickName")
                UserDefaults.standard.setValue(response.result.promise, forKey: "promise")
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
// MARK: - PersonDataModel
struct UserDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message : String
    let result: User
}

// MARK: - Person
struct User: Codable {
    let userIdx : Int
    let nickName : String
//    let photo : String
    let promise : String
}

