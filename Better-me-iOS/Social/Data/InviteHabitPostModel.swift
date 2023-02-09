//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class InviteHabitPostModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    var baseUrl = "http://54.180.13.219:3000/app/invite/1"
    
    var param = ["habitIdx": 1, "receiverIdx": 2]
    
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
    func Delete(completionHandler: @escaping (Result<[InviteHabitPostResponse], Error>) -> Void){
            print(#fileID, #function, #line, "")
            AF.request(baseUrl, method: .post).response { response in
                switch response.result {
                case .success:
                    completionHandler(.success([InviteHabitPostResponse(isSuccess: true, code: 201, message: "습관 초대 성공")]))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
