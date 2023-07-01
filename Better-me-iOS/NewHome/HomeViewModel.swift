//
//  HomeViewModel.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//


import Combine
import Foundation
import EmojiPicker

class HomeViewModel: ObservableObject {
    @Published var habitList : [Habit] = []
                        
    func formattedDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 E요일"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        return dateFormatter.string(from: date)
    }
    func formattedDate2(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        return dateFormatter.string(from: date)
    }
    func editHabit(_ editedHabit: Habit) {
        if let index = habitList.firstIndex(where: { $0.id == editedHabit.id }) {
            // Modify the element at the found index
            habitList[index].title = editedHabit.title
            habitList[index].contents = editedHabit.contents
            habitList[index].emoji = editedHabit.emoji
            // Modify other properties as needed
        }
    }
    
    func addHabitToList(_ habit: Habit) {
        habitList.append(habit)
    }
    func deleteHabit (_ habitID : UUID) {
        if let index = habitList.firstIndex(where: { $0.id == habitID }) {
            habitList.remove(at: index)
        }
    }
    func checkUpdate (_ habitID : UUID) {
        if let index = habitList.firstIndex(where: { $0.id == habitID }) {
            habitList[index].isCheck.toggle()
            if habitList[index].isCheck {
                habitList[index].hNum += 5
            }
            else {
                habitList[index].hNum -= 5
            }
        }
    }
    //체크 true -> nNum +1
    // Date 바뀌면 모든 habitList 의 check 가 false 로 변함
    // 
    
    
    
    let quotes = [
        Quote(contents: "습관이란 인간으로 하여금 그 어떤 일도 할 수 있게 만들어준다.", name: "- 도스토옙스키"),
        Quote(contents: "가난과 부, 실패와 성공은 모두 습관 때문이다.", name: "- 중국 속담"),
        Quote(contents: "타고난 본성은 비슷하지만, 습관에 의해서 달라진다.", name: "- 공자"),
        Quote(contents: "습관을 바꾸는 것만으로도 자신의 인생을 바꿀 수 있다.", name: "- 윌리엄 제임스"),
        Quote(contents: "지루해지는 비결은 모든 것을 이야기 하는 것이다.", name: "- 볼테르"),
        Quote(contents: "타인의 습관처럼 고쳐야 할 필요가 있는 것은 없다.", name: "- 마트 트웨인"),
        Quote(contents: "너 자신을 더욱 깨끗하게 밝게 유지하라. 너는 세상을 보기 위한 창문이니", name: "- 조지 버나드 쇼"),
        Quote(contents: "오랜 관습에는 심오한 의미가 담겨 있다.", name: "- 요한 프리드리히 폰 쉴러"),
        Quote(contents: "습관의 영속성은 일반적으로 습관의 불합리성과 정비례한다.", name: "- 마르셀 프로스트"),
        Quote(contents: "나쁜 습관을 떨쳐버리는 가장 좋은 방법은 절대 시작하지 않는 것이다.", name: "- 제임스 C. 페니"),
        Quote(contents: "습관은 성격으로 변한다.", name: "- 오비디우스"),
        Quote(contents: "사소한 습관 하나로 큰 범죄에 이를 수도 있다.", name: "- 한나 모어"),
        Quote(contents: "불행히도 좋은 습관은 나쁜 습관보다 포기하기가 쉽다.", name: "- 윌리엄 모음"),
        Quote(contents: "습관은 밧줄과도 같다. 날마다 한 올 한 올 엮다 보면 결국 끊지 못하게 된다.", name: "- 호레이스 만"),
        Quote(contents: "생활은 습관이 짜낸 천에 불과하다.", name: "- 아미엘"),
        Quote(contents: "네가 집착하는 것 외에 평생 너를 따라다니는 습관은 없다.", name: "- 가드너 헌팅"),
        Quote(contents: "습관은 삶의 훌륭한 안내자다.", name: "- 데이비드 흄"),
        Quote(contents: "하찮은 것일지라도 자연스러운 기질의 함양은 성품과 지론에 관한 문제다.", name: "- 존 S 호슨"),
        Quote(contents: "모두가 대문을 닫는다면 모든 거리가 깨끗해진다.", name: "- 요한 볼프강 폰 쾨테"),
        Quote(contents: "피로감 역시 술버릇과 마찬가지로 부적절한 것이다. 둘 다 나쁜 습관의 증거다.", name: "- L.G 프리먼"),
        Quote(contents: "우리의 욕구는 자연이 아닌 교육과 습관에서 비롯된다.", name: "- 헨리 필딩"),
        Quote(contents: "습관은 인간을 실수로 인도할 수도 있다. 이 경우 습관은 정당화되지 못한다.", name: "- 헨리 필딩"),
        Quote(contents: "손톱이 자라면서 없어지듯 습관은 습관에 의해 정복된다.", name: "- 에라스무스"),
        Quote(contents: "습관은 최상의 하인이 될 수도 있고, 최악의 주인이 될 수도 있다.", name: "- 나다니엘 에몬스"),
        Quote(contents: "인간의 습관과 생활방식은 큰 가지의 잎사귀처럼 변하게 마련이다. 어떤 잎은 떨어지고 새 잎이 난다.", name: "- 단테"),
        Quote(contents: "인간의 본성은 서로 비슷하지만, 후천적 습관에 의해 서로 멀어진다.", name: "- 공자"),
        Quote(contents: "비애는 만사를 귀찮하는 사람들의 몫이다. 모든 일도 그들을 싫어할 테니까 말이다.", name: "- G.K 채스터톤"),
        Quote(contents: "우리는 자연의 법칙에 따라 생각하고, 규칙에 따라 말하며, 습관에 따라 행동한다.", name: "- 프란시스 베이컨"),
        Quote(contents: "성공한 삶의 가장 큰 비밀은 목표를 정하고 성취해내는 것이다.", name: "- Henry Ford"),
        Quote(contents: "처음에는 우리가 습관을 만들지만 그 다음에는 습관이 우리를 만든다", name: "- 존 드라이든"),
        Quote(contents: "습관이 인간 생활의 위대한 안내자이다.", name: "- 데이비드 흄"),
        Quote(contents: "습관은 제 2의 천성으로 제 1의 천성을 파괴한다.", name: "- 파스칼"),
        Quote(contents: "습관은 나무 껍질에 새겨 놓은 문자 같아서 그 나무가 자라남에 따라 확대된다.", name: "- 새뮤얼 스마일스"),
        Quote(contents: "우유부단한 것만이 습관화되어 있는 사람보다 더 비참한 사람은 없다.", name: "- 제임스"),
        Quote(contents: "젊음의 잘못된 습관을 치료할 수 있는 유일한 의사가 바로 시간이다.", name: "- 그라시안"),
    ]
}






extension HomeViewModel {
    
}
