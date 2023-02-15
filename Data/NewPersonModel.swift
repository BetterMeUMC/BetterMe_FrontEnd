//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class NewPersonModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    @Published var Friends = [Priend]()
    
    @Published var nickNameArray = [String]()
    
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyMiwiaWF0IjoxNjc2MzMwNzc0LCJleHAiOjE2NzY0MTcxNzQsInN1YiI6InVzZXJJbmZvIn0.koGlzegZNzX4NsFD2QV8giVjYKBAeVE2GpAsrB-P9sU"]
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/1"
    
    init(){
        print(#fileID, #function, #line, "")
        self.Friends = Friends
        fetchRandomUsers()
        appendNickName()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl, headers: token).publishDecodable(type: FriendResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.Friends = receivedValue
            }).store(in: &subscripttion)
    }
    func appendNickName(){
        nickNameArray = Friends.map{ $0.nickName }
    }
    
}
