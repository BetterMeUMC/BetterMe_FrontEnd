//
//  AddHabitView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import SwiftUI
import EmojiPicker

struct AddHabitView: View {
    @State private var habitName = ""
    @State private var category = ""
    @State private var habitContent = ""
    @State private var isPublic = false
    @State private var inviteFriends = ""
    @State var selectedEmoji: Emoji?
    @State private var displayEmojiPicker = false
    @State private var displayRecomandedView = false
    @State private var displayPeriod = [0,0,0,0,0,0,0]
    
    let viewModel : HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing: 24){
                Spacer()
                HStack {
                    Text("대표 이모지")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                       
                        .padding(.leading)
                    Spacer()
                    Button {
                                displayEmojiPicker = true
                                } label: {
                                    Text(selectedEmoji?.value ?? "🏆")
                                        .frame(width: 50,height: 30)
                                        .background(Color("custom_gray"))
                                        .cornerRadius(8)
                                        .font(.system(size: 15))
                                }
        
                    Spacer()
                    Spacer()
                    Button{displayRecomandedView = true} label: {
                        Text("추천 습관 보기")
                            .underline()
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .font(.system(size: 15))
                            .padding(.trailing)
                    }
                    
                }
                .sheet(isPresented: $displayEmojiPicker) {
                    NavigationView {
                        EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                            .navigationTitle("Emojis")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .sheet(isPresented: $displayRecomandedView) {
                    NavigationView {
                        RecomandedHabitsModalView()
                            .navigationTitle("추천 습관")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                
                Rectangle()
                    .foregroundColor(Color("custom_gray"))
                    .frame(height: 8)
                
                HStack {
                    Text("습관명")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .padding(.leading)
                    TextField("습관명을 입력해주세요.", text: $habitName)
                        .padding()
                        .frame(height: 35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                }
                HStack {
                    Text("카테고리")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .padding(.leading)
                    TextField("여기를 눌러 카테고리를 선택하세요.", text: $category)
                        .padding()
                        .frame( height: 35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                            
                        )
                        .padding(.horizontal)
                    
                }
                VStack {
                    HStack{
                        Text("습관 내용")
                            .font(.system(size: 18, weight: .regular)) // Updated font
                            .padding(.leading)
                        Spacer()
                    }
                    
                    TextField("습관 내용을 입력하세요.", text: $habitContent)
                        .padding()
                        .padding(.bottom)
                        .frame(height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
                Rectangle()
                    .foregroundColor(Color("custom_gray"))
                    .frame(height: 8)
                
                VStack (spacing: 24) {
                    HStack{
                        Text("반복주기")
                            .font(.system(size: 18, weight: .regular))
                            .padding(.leading)
                        Spacer()
                    }
                    HStack{
                        periodCellView(displayPeriod: $displayPeriod, week: "월", index: 0)
                        periodCellView(displayPeriod: $displayPeriod, week: "화", index: 1)
                        periodCellView(displayPeriod: $displayPeriod, week: "수", index: 2)
                        periodCellView(displayPeriod: $displayPeriod, week: "목", index: 3)
                        periodCellView(displayPeriod: $displayPeriod, week: "금", index: 4)
                        periodCellView(displayPeriod: $displayPeriod, week: "토", index: 5)
                        periodCellView(displayPeriod: $displayPeriod, week: "일", index: 6)
                    }
                    .padding(.horizontal)
                }
                
                Rectangle()
                    .foregroundColor(Color("custom_gray"))
                    .frame(height: 8)
                
            }
            VStack{
                HStack {
                    Text("공개 설정")
                        .font(.system(size: 18, weight: .regular))
                        .padding(.leading)
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                    isPublic ? Text("공개") : Text("비공개")
                        .font(.system(size: 15, weight: .regular))
                    
                    Toggle(isOn: $isPublic) {
                        // Toggle action
                    }
                    .padding(.trailing)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                }
                
                Rectangle()
                    .foregroundColor(Color("custom_gray"))
                    .frame(height: 8)
                
                VStack(alignment: .leading){
                    HStack {
                        Text("친구 초대")
                            .font(.system(size: 18, weight: .regular))
                            .padding()
                        Spacer()
                    }
                    HStack {
                        TextField("친구 초대하기", text: $inviteFriends)
                            .padding()
                            .frame(height: 35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal)
                            
                        Spacer()
                        Button(action: {}) {
                            Text("찾아보기")
                                .foregroundColor(.white)
                                .padding()
                                .frame(height: 35)
                                .background(Color("Pink"))
                                .cornerRadius(5)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                    
                }
                
                Rectangle()
                    .foregroundColor(Color("custom_gray"))
                    .frame(height: 8)
                
                VStack (spacing: 24) {
                    HStack{
                        Text("테마 선택")
                            .font(.system(size: 18, weight: .regular))
                            .padding()
                        // Replace `ThemeView()` with your custom implementation
                        // or use a built-in SwiftUI view for theme selection
                        // e.g., SegmentedPicker, Picker, or a custom theme selection view
                        Spacer()
                    }
                }
            }
        }.fontWeight(.regular)
        .navigationBarItems(
            trailing:
                Button(action: saveHabit) {
                    // Save button action
                    Text("등록")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(width: 55,height: 31)
                        .background(Color("custom_red"))
                        .cornerRadius(15)
                }
        )
        .navigationBarTitle("습관 만들기", displayMode: .inline)
    }
    
    func saveHabit() {
        
        let habit = Habit(id: UUID(),hNum: 0, isCheck: false, date: Date(), emoji: selectedEmoji ?? Emoji(value: "🏆", name: "default"), title: habitName, category: category, contents: habitContent, isPublic: isPublic, with: [])
        viewModel.addHabitToList(habit)
        presentationMode.wrappedValue.dismiss()
        print(viewModel.habitList)
    }


}

struct periodCellView : View {
    @State private var isSelected = false
    @Binding var displayPeriod : [Int]
    let week : String
    let index  : Int
    
    var body : some View {
        Circle()
            .fill(isSelected ? .white : Color("Pink"))
            .overlay(
                Text(week)
                    .foregroundColor(isSelected ? Color("Pink") : .white)
                
            )
            .overlay(
                Circle()
                    .stroke(Color("Pink"), lineWidth: 2) // Set the border color to "Pink"
            )
            .onTapGesture {
                isSelected.toggle()
                displayPeriod[index] = isSelected ? 1: 0
            }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//        AddHabitView(viewModel: HomeViewModel())
    }
}
