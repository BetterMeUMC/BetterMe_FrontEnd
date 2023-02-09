//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class Request_Friend_PostModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    var baseUrl = "http://54.180.13.219:3000/app/follow/request/:userIdx/:followee"
    
    var token: HTTPHeaders = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzU5MTgyNjksImV4cCI6MTY3NjAwNDY2OSwic3ViIjoidXNlckluZm8ifQ.PyrzZVmeAAJ2KggsvNbYh1Qp9tC-0Swd_MULrN9Gmbs"]
    
    init(){
        print(#fileID, #function, #line, "")
        //        fetchRandomUsers()
    }
    
    
    func Post(completionHandler: @escaping (Result<[Request_Friend_PostResponse], Error>) -> Void) {
        print(#fileID, #function, #line, "")
        AF.request(baseUrl, method: .post, headers: token).response { response in
            switch response.result {
            case .success:
                completionHandler(.success([Request_Friend_PostResponse(isSuccess: true, code: 1000, message: "성공")]))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
