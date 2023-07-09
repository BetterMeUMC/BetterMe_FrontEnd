//
//  RecomandedHabitsModalView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/29.
//

import SwiftUI

struct RecomandedHabitsModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack(alignment: .leading, spacing: 30){
                    Text("\u{2022} 일어나자마자 이불개기")
                    Text("\u{2022} 책 20 분 읽기")
                    Text("\u{2022} 런닝머신 40분 타기")
                    Text("\u{2022} 근력운동 매일 하기")
                    Text("\u{2022} 영어 팟캐스트 듣기")
                    Text("\u{2022} 비타민 챙겨먹기")
                    Text("\u{2022} 일어나자마자 스트레칭하기")
                    Text("\u{2022} 일기쓰기")
                    
                    
                }.padding()
                Spacer()
            }
            Spacer()
            Divider()
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("닫기")
                    .frame(width: 375, height: 75)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    
            }
            .frame(width: 40, height: 20, alignment: .center)
            .padding(20)
            
   
        }.font(.system(size:18))
        .background(
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                EmptyView()
            }
                .buttonStyle(PlainButtonStyle())
        )
    }
}

struct RecomandedHabitsModalView_Previews: PreviewProvider {
    static var previews: some View {
        RecomandedHabitsModalView()
    }
}
