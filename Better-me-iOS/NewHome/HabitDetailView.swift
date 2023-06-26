//
//  HabitDetailView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import SwiftUI

struct HabitDetailView: View {
    @State private var habitName = ""
    @State private var habitContent = ""
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
                    Spacer()
                    
                }
                
                
                HStack {
                    Text("습관명")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .fontWeight(.bold)
                        .padding(.leading)
                    TextField("습관명을 입력해주세요.", text: $habitName)
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
                        .frame(height: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                VStack {
                    HStack {
                        Text("친구 초대")
                            .font(.system(size: 18, weight: .regular))
                            .fontWeight(.bold)
                            .padding()
                        Spacer()
                    }
                    HStack {
                        TextField("누구와 함께 하고 있나요?", text: $inviteFriends)
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
                    List{
                        //함꼐하는 친구 리스트
                    }
                }
            }
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView()
    }
}
