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
    var baseUrl = "http://54.180.13.219:3000/app/follow/1"
    
    init(){
        print(#fileID, #function, #line, "")
        self.Friends = Friends
        fetchRandomUsers()
        appendNickName()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl).publishDecodable(type: FriendResponse.self)
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
