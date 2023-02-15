//
//  People.swift
//  BetterMe-SwiftUI
//
//  Created by 황인성 on 2023/01/16.
//

import Foundation





class PersonModel: ObservableObject {
    @Published var people = [Person]()
    
    init(){
        people.append(Person(name: "신디", online: false, like: 17, habit: "일어나자마자 이불개기"))
        people.append(Person(name: "리미", online: true, like: 23))
        people.append(Person(name: "매버릭", online: true, like: 7, habit: "일어나자마자 양치하기"))
        people.append(Person(name: "범", online: false, like: 2))
        people.append(Person(name: "폴", online: false, like: 9, habit: "일어나자마자 아침먹기"))
        people.append(Person(name: "벨라", online: true, like: 0))
        people.append(Person(name: "피딕", online: false, like: 8, habit: "일어나자마자 과제하기"))
        people.append(Person(name: "주니", online: false, like: 10, habit: "일어나자마자 청소하기"))
        people.append(Person(name: "포디", online: true, like: 11))
        people.append(Person(name: "혀니", online: false, like: 13))
    }
    
    

}



