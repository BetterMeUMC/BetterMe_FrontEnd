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
    
        
    let maxComplete : Double = 30
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
                        HStack{
                            Text(viewModel.formattedDate2(date: habit.date))
                                .font(.system(size: 11))
                                .foregroundColor(.gray)
                            GaugeBar(maxValue: maxComplete, currentValue: Double(habit.hNum))
                        }
                    }
                    Spacer()
                    Button(action: {
                        viewModel.checkUpdate(habit.id)
                    }) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 27, height: 27)
                            .foregroundColor(.gray)
                            .overlay(
                                Group {
                                    if habit.isCheck {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                    } else {
                                        EmptyView()
                                    }
                                }
                            )
                    }
                }
                .padding()
                
            }
        }
    }
}




//struct CheckboxView: View {
//    @Binding var isChecked: Bool
//    let viewModel : HomeViewModel
//    var body: some View {
//        Button(action: {
//            isChecked.toggle()
//            viewModel.checkH(<#T##habitID: UUID##UUID#>)
//        }) {
//            RoundedRectangle(cornerRadius: 5)
//                .frame(width: 27, height: 27)
//                .foregroundColor(.gray)
//                .overlay(
//                    Group {
//                        if isChecked {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.white)
//                        } else {
//                            EmptyView()
//                        }
//                    }
//                )
//        }
//    }
//}

struct GaugeBar: View {
    let maxValue: Double
    let currentValue: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.gray)
                .frame(width: 107,height: 5)
            
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.red)
                .frame(width: calculateGaugeWidth(), height: 5)
                
        }
    }
    
    private func calculateGaugeWidth() -> CGFloat {
        let percentage = currentValue / maxValue
        return CGFloat(percentage) * 107
    }
    

}


struct HabitCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
