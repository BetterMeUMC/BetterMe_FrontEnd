//
//  GetPersonDataService.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/05.
//

import Foundation
import Alamofire


class GetPersonDataService { 
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzU2MDExMDcsImV4cCI6MTY3NTY4NzUwNywic3ViIjoidXNlckluZm8ifQ.6Wrarb51SFjYEjVSiE7W2rS-8GWmqK9imLo4tiV1tXQ"
    let userIdx = "1"
    var person : Person?

    
    
    func confidureImagefromURL() {

        guard let url = URL(string: "http://54.180.13.219:3000/app/users/getMyPage/\(userIdx)") else {return}
        let header: HTTPHeaders = [
            "x-access-token" : token
        ]
        
        let request = AF.request(url, method: .get,headers: header)
        
        request.publishDecodable(type: PersonDataModel.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                self.person = receivedValue
            })
        
        
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
struct PersonDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let messege : String
    let result: Person
}

// MARK: - Person
struct Person: Codable {
    let userIdx : Int
    let nickName : String
//    let photo : String
    let promise : String
}
//AF.request(baseUrl).publishDecodable(type: FriendSearchResponse.self)
//            .compactMap{ $0.value }
//            .map{ $0.result }
//            .sink(receiveCompletion: { completion in
//                print("데이터스트림 완료")
//            }, receiveValue: { receivedValue in
//                print("받은 값 : \(receivedValue.count)")
//                self.FriendsSearch = receivedValue
//            }).store(in: &subscripttion)
