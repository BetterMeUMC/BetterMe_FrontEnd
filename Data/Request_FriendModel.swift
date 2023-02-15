//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class Request_FriendModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    @Published var RequestFriends = [RequestFriend]()
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzYxODk3OTQsImV4cCI6MTY3NjI3NjE5NCwic3ViIjoidXNlckluZm8ifQ.-Y5SClfOe9Jq5TEmpnWQtEaQ3Qg6mhuKQZ2AGUQGacg"]
    
    var param = [ "followee": [20, 33] ]
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/request/2"
    
    init(){
        print(#fileID, #function, #line, "")
        fetchRandomUsers()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl, headers: token).publishDecodable(type: RequestFriendResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.RequestFriends = receivedValue
            }).store(in: &subscripttion)
    }
    
}
