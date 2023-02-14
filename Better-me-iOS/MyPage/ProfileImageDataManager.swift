//
//  ProfileImageDataManager.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/12.
//
import Foundation
import Alamofire
import UIKit

class ProfileImageDataManager {
    
    let token = UserDefaults.standard.string(forKey: "token")
    let userIdx = UserDefaults.standard.string(forKey: "userIdx")
   
    func patchProfilePhoto(imgData: Data) {
        guard let url = URL(string: "http://54.180.13.219:3000/app/users/upload/\(userIdx ?? "")") else {return}
            
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data", "Accept":"application/json", "x-access-token": token ?? ""]
    
        
        AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "profile", fileName: "photo.png", mimeType: "image/png")
        }, to: url, method: .patch, headers: header)
        .validate()
        .responseDecodable(of: patchUserResponseStruct.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess{
                    print("Photo 서버 디렉토리 저장")
                } else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
