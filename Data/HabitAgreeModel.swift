//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class HabitAgreeModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    var baseUrl = "http://54.180.13.219:3000/app/invite/accept/1/1"
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzYxODk3OTQsImV4cCI6MTY3NjI3NjE5NCwic3ViIjoidXNlckluZm8ifQ.-Y5SClfOe9Jq5TEmpnWQtEaQ3Qg6mhuKQZ2AGUQGacg"]
    
//    var param = ["followee": [20, 33]]
    
    init(){
        print(#fileID, #function, #line, "")
//        fetchRandomUsers()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl, headers: token).publishDecodable(type: HabitAgreeResponse.self)
            .compactMap{ $0.value }
//            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue)")
//                self.InviteHabits = receivedValue
            }).store(in: &subscripttion)
    }
    

//    func Patch(completionHandler: @escaping (Result<[HabitAgreeResponse], Error>) -> Void){
//            print(#fileID, #function, #line, "")
//            AF.request(baseUrl, method: .patch).response { response in
//                switch response.result {
//                case .success:
//                    completionHandler(.success([HabitAgreeResponse(isSuccess: true, code: 201, message: "습관 초대 수락 성공")]))
//                case .failure(let error):
//                    completionHandler(.failure(error))
//                }
//            }
//    }
}
