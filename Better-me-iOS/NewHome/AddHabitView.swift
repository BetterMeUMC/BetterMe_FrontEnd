//
//  AddHabitView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import SwiftUI

struct AddHabitView: View {
    @State private var habitName = ""
    @State private var category = ""
    @State private var habitContent = ""
    @State private var isPublic = false
    @State private var inviteFriends = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24){
                Spacer()
                HStack {
                    Text("대표 이모지")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button(action: {}) {
                        // Add button action
                        Text("emoji")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .font(.system(size: 15))
                    }
                    Spacer()
                    Spacer()
                    Button(action: {}) {
                        // Add button action
                        Text("추천 습관 보기")
                            .underline()
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .font(.system(size: 15))
                            .padding(.trailing)
                    }
                    
                }
                
                Divider().frame(height: 8).background(Color.gray.opacity(0.3)) // Updated divider color
                
                HStack {
                    Text("습관명")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .fontWeight(.bold)
                        .padding(.leading)
                    TextField("습관명을 입력해주세요.", text: $habitName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                }
                HStack {
                    Text("카테고리")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .fontWeight(.bold)
                        .padding(.leading)
                    TextField("여기를 눌러 카테고리를 선택하세요.", text: $category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                }
                VStack {
                    HStack{
                        Text("습관 내용")
                            .font(.system(size: 18, weight: .regular)) // Updated font
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    
                    TextField("습관 내용을 입력하세요.", text: $habitContent)
                        .frame(height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
                Divider().frame(height: 8).background(Color.gray.opacity(0.3))
                
                VStack (spacing: 24) {
                    HStack{
                        Text("반복주기")
                            .font(.system(size: 18, weight: .regular))
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    // Replace `periodView()` with your custom implementation
                    // or use a built-in SwiftUI view for the period selection
                    // e.g., DatePicker, Picker, or Stepper
                }
                
                Divider().frame(height: 8).background(Color.gray.opacity(0.3))
            }
            VStack{
                HStack {
                    Text("공개 설정")
                        .font(.system(size: 18, weight: .regular))
                        .fontWeight(.bold)
                        .padding(.leading)
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .padding(.trailing)
                    }
                    isPublic ? Text("공개") : Text("비공개")
                        .font(.system(size: 15, weight: .regular))
                        .fontWeight(.bold)
                    
                    Toggle(isOn: $isPublic) {
                        // Toggle action
                    }
                    .padding(.trailing)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                }
                
                Divider().frame(height: 8).background(Color.gray.opacity(0.3))
                
                VStack {
                    HStack {
                        Text("친구 초대")
                            .font(.system(size: 18, weight: .regular))
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    HStack {
                        TextField("친구 초대하기", text: $inviteFriends)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.trailing)
                        Button(action: {}) {
                            Text("찾아보기")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                    }
                    .padding(.horizontal)
                    
                    
                }
                Divider().frame(height: 8).background(Color.gray.opacity(0.3))
                
                VStack (spacing: 24) {
                    HStack{
                        Text("테마 선택")
                            .font(.system(size: 18, weight: .regular))
                            .fontWeight(.bold)
                            .padding()
                        // Replace `ThemeView()` with your custom implementation
                        // or use a built-in SwiftUI view for theme selection
                        // e.g., SegmentedPicker, Picker, or a custom theme selection view
                        Spacer()
                    }
                }
            }
        }
        .navigationBarItems(
            trailing:
                Button(action: saveHabit) {
                    // Save button action
                    Text("Save")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
        )
        .navigationBarTitle("습관 만들기", displayMode: .inline)
    }
    
    func saveHabit() {
        // Function implementation to save the habit
    }
    
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
