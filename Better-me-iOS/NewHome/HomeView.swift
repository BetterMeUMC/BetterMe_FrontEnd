//
//  HomeView.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/06/27.
//
import SwiftUI
import EmojiPicker

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var isAddingHabit = false
    var randomQuote: Quote {
            viewModel.quotes.randomElement() ?? Quote(contents: "", name: "")
        }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 340, height: 60)
                        .foregroundColor(.gray)
                        .overlay(
                            HStack{
                                Text(randomQuote.contents)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                Text(randomQuote.name)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding(.top)
                            }
                            .padding(.horizontal)
                        )
                        .padding()
                    
                    Text(viewModel.formattedDate(date: Date()))
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    Text("습관 목록")
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                

                        ForEach(viewModel.habitList, id: \.id) {
                            habit in HabitCellView(viewModel: viewModel, habit: habit)
                        }

                    NavigationLink(destination: AddHabitView(viewModel: viewModel)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(red: 1, green: 0.5, blue: 0.5))
                                .frame(width: 340, height: 60)
                            
                            Image(systemName: "plus")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading:
                                        Image("BetterMeLogo")
                    .resizable()
                    .frame(width: 127, height: 28)
                )
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
