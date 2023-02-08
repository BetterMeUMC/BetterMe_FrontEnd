//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class FriendSearchModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    @Published var FriendsSearch = [FriendSearch]()
    
//    var params = 
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/1"
    
    init(){
        print(#fileID, #function, #line, "")
        fetchRandomUsers()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl).publishDecodable(type: FriendSearchResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.FriendsSearch = receivedValue
            }).store(in: &subscripttion)
        
    }
    
    
}
