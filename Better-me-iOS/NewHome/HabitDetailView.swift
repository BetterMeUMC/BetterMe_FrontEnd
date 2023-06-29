//
//  HabitDetailView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import SwiftUI
import EmojiPicker

struct HabitDetailView: View {
    
    

    
    
    let viewModel : HomeViewModel
    let habit : Habit
    @Environment(\.presentationMode) var presentationMode
    @State private var changedHabitName = ""
    @State private var changedHabitContent = ""
    @State private var inviteFriends = ""
    @State var selectedEmoji: Emoji?
    @State private var displayEmojiPicker = false
    
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
                    Button {
                                displayEmojiPicker = true
                                } label: {
                                    Text(selectedEmoji?.value ?? habit.emoji.value)
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
                .sheet(isPresented: $displayEmojiPicker) {
                    NavigationView {
                        EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                            .navigationTitle("Emojis")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                
                HStack {
                    Text("습관명")
                        .font(.system(size: 18, weight: .regular)) // Updated font
                        .fontWeight(.bold)
                        .padding(.leading)
                    TextField(habit.title, text: $changedHabitName)
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
                    
                    TextField(habit.contents, text: $changedHabitContent)
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
            }.onDisappear {
                let editedHabit = Habit(id: habit.id ,hNum: habit.hNum, isCheck: habit.isCheck, date: habit.date, emoji: selectedEmoji ?? habit.emoji, title: changedHabitName, category: habit.category, contents: changedHabitContent, isPublic: habit.isPublic, with: habit.with)
                viewModel.editHabit(editedHabit)
            }
        }.navigationBarItems(
            trailing:
                Button(action: {deleteHabit(habit.id)}){
                    // Save button action
                    Image("delete")
                        .frame(width: 30,height: 30)
                }
        )
        .navigationBarTitle("습관 만들기", displayMode: .inline)
    }
    func deleteHabit(_ habitID : UUID) {
        viewModel.deleteHabit(habitID)
        presentationMode.wrappedValue.dismiss()
    }
}

struct HabitDetailView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
    }
}
