//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by 황인성 on 2023/02/03.
//

import Foundation
import Combine
import Alamofire

class InviteHabitModel: ObservableObject{
    
    var subscripttion = Set<AnyCancellable>()
    
    @Published var InviteHabits = [InviteHabit]()
    
    var baseUrl = "http://54.180.13.219:3000/app/invite/2"
    
    init(){
        print(#fileID, #function, #line, "")
        fetchRandomUsers()
    }
    
    func fetchRandomUsers(){
        print(#fileID, #function, #line, "")
        AF.request(baseUrl).publishDecodable(type: InviteHabitResponse.self)
            .compactMap{ $0.value }
            .map{ $0.result }
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.InviteHabits = receivedValue
            }).store(in: &subscripttion)
    }
    
}
