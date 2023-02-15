//
//  NotificationManager.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/15.
//

import Foundation
import Alamofire

class NotificationManager {
    let token = UserDefaults.standard.string(forKey: "token")
    let userIdx = UserDefaults.standard.string(forKey: "userIdx")
    
    func patchHabitCheckOn() {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/alarm/habitCheck/on/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]

        AF.request(url,
                   method: .patch,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func patchHabitCheckOff() {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/alarm/habitCheck/off/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]

        AF.request(url,
                   method: .patch,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func patchHabitInviteCheckOn() {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/alarm/habitInvite/on/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]

        AF.request(url,
                   method: .patch,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    func patchHabitInviteCheckOff() {
        
        guard let url = URL(string: "http://54.180.13.219:3000/app/alarm/habitInvite/off/\(userIdx ?? "")") else {return}
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]

        AF.request(url,
                   method: .patch,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
