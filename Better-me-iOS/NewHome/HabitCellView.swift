//
//  HabitCellView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//

import SwiftUI
import EmojiPicker

struct HabitCellView: View {
    let viewModel : HomeViewModel
    let habit : Habit
    @State private var isChecked = false
        
    var body: some View {
        NavigationLink(destination: HabitDetailView(viewModel : viewModel, habit: habit)) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 60)
        
                HStack{
                    VStack{
                        Text(habit.emoji.value)
                            .padding(.bottom)
                    }
                    VStack(alignment: .leading){
                        Text(habit.title)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            
                        Text(viewModel.formattedDate2(date: habit.date))
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    CheckboxView(isChecked: $isChecked)
                        .frame(width: 27, height: 27)
                        .cornerRadius(5)
                        .foregroundColor(.gray)
                }
                .padding()
                
            }
        }
    }
}
struct CheckboxView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 27, height: 27)
                .foregroundColor(.gray)
                .overlay(
                    Group {
                        if isChecked {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                        } else {
                            EmptyView()
                        }
                    }
                )
        }
    }
}


struct HabitCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
