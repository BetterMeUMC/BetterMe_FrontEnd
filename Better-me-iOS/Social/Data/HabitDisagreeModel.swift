//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class HabitDisagreeModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    var baseUrl = "http://54.180.13.219:3000/app/invite/accpet/:userIdx/:habitIdx"
    
    var param = ["followee": [20, 33]]
    
    init(){
        print(#fileID, #function, #line, "")
//        fetchRandomUsers()
    }
    
    func Patch(completionHandler: @escaping (Result<[HabitDisagreeResponse], Error>) -> Void){
            print(#fileID, #function, #line, "")
            AF.request(baseUrl, method: .patch).response { response in
                switch response.result {
                case .success:
                    completionHandler(.success([HabitDisagreeResponse(isSuccess: true, code: 201, message: "습관 초대 거절 성공")]))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
