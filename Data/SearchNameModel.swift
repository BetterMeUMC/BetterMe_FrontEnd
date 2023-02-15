//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire
//import SwiftyJSON

class SearchNameModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    //    var param = ["nickName": "포"] as Dictionary
    let param: [String: Any] = ["nickName": "포"]
    @Published var SearchNames = [SearchName]()
    
    @Published var name = ""
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxNSwiaWF0IjoxNjc2NDQ1MjExLCJleHAiOjE2NzY1MzE2MTEsInN1YiI6InVzZXJJbmZvIn0.FVP6kVmjA-D8cC1e4Za0-vt6xwifx_k54N_UwTLwafg"]
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/searchN/15"
    
    
    
    init(){
        print(#fileID, #function, #line, "")
        //        fetchRandomUsers()
    }
    
    
    func fetchRandomUsers(){
        
        //        var name = self.name
        print(#fileID, #function, #line, "")
        AF.request(baseUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: token).publishDecodable(type: SearchNameResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료3")
            }, receiveValue: { receivedValue in
                print("hello")
                self.SearchNames = receivedValue
            }).store(in: &subscripttion)
    }
    func getUserInfoData() {
        
        //            guard let url = URL(string: "http://54.180.13.219:3000/app/users/getMyPage/\(userIdx ?? "")") else {return}
        //            let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token ?? ""]
        
        AF.request(baseUrl,
                   method: .get,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: token)
        .responseDecodable(of: SearchNameResponse.self) { response in
            switch response.result {
            case .success(let response):
                print(response.message)
                
            case .failure(let error):
                print("sd")
                print(error)
                
            }
        }
    }
}
