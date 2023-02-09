//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class AgreeModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
//    @Published var SearchNames = [SearchName]()
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/accept/1/2"
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzU5MTgyNjksImV4cCI6MTY3NjAwNDY2OSwic3ViIjoidXNlckluZm8ifQ.PyrzZVmeAAJ2KggsvNbYh1Qp9tC-0Swd_MULrN9Gmbs"]
    
//    var param = ["nickName": "김"]
    
    init(){
        print(#fileID, #function, #line, "")
//        fetchRandomUsers()
    }
    
//    func fetchRandomUsers(){
//        print(#fileID, #function, #line, "")
//        AF.request(baseUrl, method: .patch).publishDecodable(type: AgreeResponse.self)
//            .compactMap{ $0.value }
//            .map{ $0.result }
//            .sink(receiveCompletion: { completion in
//                print("데이터스트림 완료")
//            }, receiveValue: { receivedValue in
//                print("받은 값 : \(receivedValue.count)")
//                self.SearchNames = receivedValue
//            }).store(in: &subscripttion)
//    }
    func patch(){
//        func fetchRandomUsers(){
            print(#fileID, #function, #line, "")
            AF.request(baseUrl, method: .patch, headers: token).responseString { (response) in
                switch response.result {
                case .success:
                    print("POST 성공")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
//        }
    }
}


