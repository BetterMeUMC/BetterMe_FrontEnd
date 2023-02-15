//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class RequestStatusModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    @Published var RequestStatuses = [RequestStatus]()
    
//    @Published var nickNameArray = [String]()
    
    var baseUrl = "http://54.180.13.219:3000/app/invite/response/:userIdx"
    
    init(){
        print(#fileID, #function, #line, "")
        self.RequestStatuses = RequestStatuses
        fetchRandomUsers()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl).publishDecodable(type: RequestStatusResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.RequestStatuses = receivedValue
            }).store(in: &subscripttion)
    }
    
}
