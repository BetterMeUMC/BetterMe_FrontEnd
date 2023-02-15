//
//  ContentView.swift
//  BetterMe-SwiftUI
//
//  Created by 황인성 on 2023/01/11.
//

import SwiftUI
import PopupView
import Alamofire

struct NewSearchBar: View {
    
    @Binding var text:String
    @State var searchText = ""
    
    var body: some View {
        HStack {
            HStack {
                TextField("친구 찾기", text: $text)
                    .underlineTextField()
                    .foregroundColor(.primary)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
                
                Button(action: {
                    self.searchText = self.text
                    print(searchText)
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
                
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

struct FriendSearchView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var data = SearchEmailModel()
    
    @State var array = ["신디", "리미", "매버릭", "범", "벨라", "폴", "피딕", "주니", "포디", "혀니", "asd", "asd","asd","Asd"]
    
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            NewSearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            List(data.SearchEmails, id: \.self) { searchText in
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.30)).cornerRadius(8).frame(height: 55)
                    
                    HStack {
                        Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
                            .foregroundColor(Color.random()).padding(.leading)
                        Text(searchText.nickName)
                    }.listRowSeparator(.hidden)
                }
            }.listRowSeparator(.hidden)
        } //리스트의 스타일 수정
        .listStyle(PlainListStyle())
        //화면 터치시 키보드 숨김
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image("Vector2")
        })
        )
    }
}


extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.black)
            .padding(10)
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct CheckboxFieldView: View {
    
    @State var checkState: Bool = false
    
    var body: some View {
        
        Button(action:
                {
            self.checkState = !self.checkState
            print("State : \(self.checkState)")
        }) {
            HStack(alignment: .top, spacing: 10) {
                
                //2. Will update according to state
                Rectangle()
                    .fill(self.checkState ? Color.green : Color.red)
                    .frame(width:20, height:20, alignment: .center)
                    .cornerRadius(5)
                
            }
        }
        .foregroundColor(Color.white)
        
    }
    
}


struct SecondView: View{
    
    @ObservedObject var data = Request_FriendModel()
    @ObservedObject var agree = AgreeModel()
    
    @State var show1 = false
    @State var show2 = false
    @State var name = "default"
    
    
    
    
    var body: some View{
        
        ZStack {
            List{
                ForEach(data.RequestFriends, id: \.self){ request in
                    HStack{
                        Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
                            .foregroundColor(Color.random())
                        Text(request.nickName)
                        Spacer()
                        Button(action: {
                            print("거절")
                            self.name = request.nickName
                            self.show2 = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.5)
                                    .stroke(Color.red, lineWidth: 1)
                                    .frame(width: 58, height: 31)
                                Text("거절")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.red)
                                    .lineSpacing(18.20)
                            }
                            
                        })
                        Button(action: {
                            print("수락")
                            self.name = request.nickName
                            self.show1 = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.5)
                                    .frame(width: 58, height: 31)
                                    .foregroundColor(.red)
                                Text("수락")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .lineSpacing(18.20)
                            }
                        })
                    }
                }.buttonStyle(BorderlessButtonStyle())
            }.frame( maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .listStyle(PlainListStyle())
        }
        .popup(isPresented: $show1, view: {
            self.AgreePopUp(name2: name)
        }, customize: {
            $0
                .type (.default)
                .position(.top)
                .dragToDismiss(true)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        })
        .popup(isPresented: $show2, view: {
            self.DisagreePopUp(name2: name)
        }, customize: {
            $0
                .type (.default)
                .position(.top)
                .dragToDismiss(true)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        })
    }
    func AgreePopUp(name2: String) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .frame(width: 252, height: 248)
            VStack{
                Text("공유해요!")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .frame(width: 76, height: 28, alignment: .top)
                
                Spacer().frame(height: 35)
                
                Text("\(name2) 님의")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("친구요청을 수락하시겠습니까?")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 30)
                
                HStack{
                    Button(action: {
                        print("취소")
                        self.show1 = false
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                                .stroke(Color.red, lineWidth: 1)
                                .frame(width: 58, height: 31)
                            Text("취소")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineSpacing(18.20)
                        }
                    })
                    Spacer().frame(width: 30)
                    Button(action: {
                        print("좋아요!")
                        self.show1 = false
                        self.agree.patch()

                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                            
                                .frame(width: 58, height: 31)
                                .foregroundColor(.red)
                            Text("좋아요!")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(18.20)
                        }
                    })
                }
            }
        }
    }
    func DisagreePopUp(name2: String) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .frame(width: 252, height: 248)
            VStack{
                Text("아쉽네요")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .frame(width: 76, height: 28, alignment: .top)
                
                Spacer().frame(height: 35)
                
                Text("\(name2) 님의")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("친구요청을 거절하시겠습니까?")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 30)
                
                HStack{
                    Button(action: {
                        print("취소")
                        self.show2 = false
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                                .stroke(Color.red, lineWidth: 1)
                                .frame(width: 58, height: 31)
                            Text("취소")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineSpacing(18.20)
                        }
                    })
                    Spacer().frame(width: 30)
                    Button(action: {
                        print("좋아요!")
                        self.show2 = false
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                            
                                .frame(width: 58, height: 31)
                                .foregroundColor(.red)
                            Text("좋아요!")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(18.20)
                        }
                    })
                }
            }
        }
    }
}


struct ThirdView: View{
    
    @State var show1 = false
    @State var show2 = false
    @State var name = "default"
    @State var habit = "default"
    
    @ObservedObject var data = InviteHabitModel()
    @ObservedObject var agreeData = HabitAgreeModel()
    @ObservedObject var disagreeData = HabitDisagreeModel()
    
    var body: some View{
        ZStack {
            List(data.InviteHabits, id: \.self){ invite in
                //                ForEach(model.people){ p in
                HStack{
                    VStack(alignment: .leading){
                        ZStack {
                            RoundedRectangle(cornerRadius: 19.50)
                                .fill(Color(red: 1, green: 0.92, blue: 0.92))
                                .frame(width: 74, height: 27)
                            HStack {
                                Image(systemName: "person.circle.fill").resizable().frame(width: 19, height: 19)
                                    .foregroundColor(Color.random())
                                Text(String(invite.senderIdx)).fontWeight(.semibold)
                                    .font(.caption)
                                    .lineSpacing(16.80)
                            }
                        }
                        HStack(alignment: .top) {
                            Text("😊")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .lineSpacing(21)
                            VStack {
                                Text(invite.habitName)
                                Text(invite.contents)
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            self.name = String(invite.senderIdx)
                            self.habit = invite.habitName
                            print("수락")
                            self.show1 = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.5)
                                    .frame(width: 58, height: 31)
                                    .foregroundColor(.red)
                                Text("수락")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .lineSpacing(18.20)
                            }
                        })
                        Button(action: {
                            self.name = String(invite.senderIdx)
                            self.habit = invite.contents
                            print("거절")
                            self.show2 = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.5)
                                    .stroke(Color.red, lineWidth: 1)
                                    .frame(width: 58, height: 31)
                                Text("거절")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.red)
                                    .lineSpacing(18.20)
                            }
                        })
                    }.buttonStyle(BorderlessButtonStyle())
                    //                    }
                }
            }.listStyle(PlainListStyle())
        }
        .popup(isPresented: $show1, view: {
            self.AgreePopUp(name2: name, habit2: habit)
        }, customize: {
            $0
                .type (.default)
                .position(.top)
                .dragToDismiss(true)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        })
        .popup(isPresented: $show2, view: {
            self.DisagreePopUp(name2: name, habit2: habit)
        }, customize: {
            $0
                .type (.default)
                .position(.top)
                .dragToDismiss(true)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
        })
        
    }
    
    func AgreePopUp(name2: String, habit2: String) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .frame(width: 252, height: 248)
            VStack{
                Text("화이팅")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .frame(width: 52, height: 28, alignment: .top)
                
                Spacer().frame(height: 35)
                
                Text("\(name2) 님께서 보내신")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("[ \(habit2) ]")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("습관초대를 수락하시겠습니까?")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 30)
                
                HStack{
                    Button(action: {
                        print("취소")
                        self.show1 = false
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                                .stroke(Color.red, lineWidth: 1)
                                .frame(width: 58, height: 31)
                            Text("취소")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineSpacing(18.20)
                        }
                    })
                    Spacer().frame(width: 30)
                    Button(action: {
                        print("좋아요!")
                        self.show1 = false
                        agreeData.fetchRandomUsers()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                            
                                .frame(width: 58, height: 31)
                                .foregroundColor(.red)
                            Text("좋아요!")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(18.20)
                        }
                    })
                }
            }
        }
    }
    func DisagreePopUp(name2: String, habit2: String) -> some View{
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
                .frame(width: 252, height: 248)
            VStack{
                Text("화이팅")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .frame(width: 52, height: 28, alignment: .top)
                
                Spacer().frame(height: 35)
                
                Text("\(name2) 님께서 보내신")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("[ \(habit2) ]")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 21)
                
                Text("습관초대를 거절하시겠습니까?")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .lineSpacing(21)
                
                Spacer().frame(height: 30)
                
                HStack{
                    Button(action: {
                        print("취소")
                        self.show2 = false
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                                .stroke(Color.red, lineWidth: 1)
                                .frame(width: 58, height: 31)
                            Text("취소")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.red)
                                .lineSpacing(18.20)
                        }
                    })
                    Spacer().frame(width: 30)
                    Button(action: {
                        print("좋아요!")
                        self.show2 = false
                        disagreeData.fetchRandomUsers()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.5)
                            
                                .frame(width: 58, height: 31)
                                .foregroundColor(.red)
                            Text("좋아요!")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .lineSpacing(18.20)
                        }
                    })
                }
            }
        }
    }
}

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    @Namespace var animation
    var body: some View {
        HStack {
            
            TabBarButton(text: "친구", isSelected: .constant(tabIndex == 0))
                .onTapGesture { onButtonTapped(index: 0) }
            
            Spacer()
            TabBarButton(text: "친구 요청", isSelected: .constant(tabIndex == 1))
                .onTapGesture { onButtonTapped(index: 1) }
            
            Spacer()
            TabBarButton(text: "습관 초대", isSelected: .constant(tabIndex == 2))
                .onTapGesture { onButtonTapped(index: 2) }
            
        }
        .border(width: 1, edges: [.bottom], color: .clear)
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .foregroundColor(isSelected ? .red : .gray)
            .frame(width: 122)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 0, edges: [.bottom], color: .red)
    }
}

struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

//struct SortButtonView: View{
//    var body: some View{
//        VStack{
//            Button(action: {
//
//            }, label: {
//                Text("상장 많은 순")
//            })
//            Spacer()
//            Button(action: {
//
//            }, label: {
//                Text("상장 적은 순")
//            })
//            Spacer()
//            Button(action: {
//
//            }, label: {
//                Text("가나다 순")
//            })
//            Spacer()
//            Button(action: {
//
//            }, label: {
//                Text("최근 추가순")
//            })
//            Spacer()
//            Button(action: {
//
//            }, label: {
//                Text("오래된 순")
//            })
//        }
//    }
//}

//
//struct SortView: View {
//
//    @Environment(\.presentationMode) private var presentationMode
//
//    var body: some View {
//        NavigationView{
//            VStack(alignment: .leading){
//                Rectangle().frame(height: 0)
//                SortButtonView()
//                Spacer()
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Text("닫기").frame(width: 375, height: 80).foregroundColor(.black
//                    )
//                })
//            }.padding(.leading)
//                .navigationBarTitle("정렬", displayMode: .inline)
//        }
//    }
//}

//struct SearchBar: View {
//
//    @Binding var text: String
//
//    @ObservedObject var data = SearchNameModel()
//
//    var body: some View {
//        HStack {
//            HStack {
//                TextField("친구 찾기", text: $text)
//                    .underlineTextField()
//                    .foregroundColor(.primary)
//
//                if !text.isEmpty {
//                    Button(action: {
//                        self.text = ""
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                    }
//                } else {
//                    EmptyView()
//                }
//
//                Button(action: {
//                    data.fetchRandomUsers(name: text)
//                }, label: {
//                    Image(systemName: "magnifyingglass")
//                })
//
//            }
//            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
//            .foregroundColor(.secondary)
//        }
//        .padding(.horizontal)
//    }
//}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct SearchView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var data = SearchNameModel()
    
    @Binding var text: String

    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
//                SearchBar(text: $searchText)

                    HStack {
                        TextField("친구 찾기", text: $text)
                            .underlineTextField()
                            .foregroundColor(.primary)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                        } else {
                            EmptyView()
                        }
                        
                        Button(action: {
                            data.fetchRandomUsers()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                        
                    }
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.secondary)

                
                List(data.SearchNames, id:\.self) { searchText in
                    ZStack(alignment: .leading) {
                        Rectangle().foregroundColor(.secondary).cornerRadius(8).frame(height: 55)
                        
                        HStack {
                            Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
                                .foregroundColor(Color.random()).padding(.leading)
                            Text(searchText.nickName)
                        }.listRowSeparator(.hidden)
                    }
                }
            } //리스트의 스타일 수정
            .listStyle(PlainListStyle())
            //화면 터치시 키보드 숨김
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("Vector2")
            })
            )
        }
    }
}
//}




struct FriendView: View {
    
    @ObservedObject var model = PersonModel()
    @State var showModal = false
    @State var showModalSearch = false
    @State var searchText = ""
    
    @State var numbers = ["Record1","Record2","Record3","Record4","Record5","Record6","Record1Seven","Record1Eight","Record1Nine","Record1Ten"]
    @State var editMode = EditMode.inactive
    @State var selection = Set<String>()
    @ObservedObject var data = NewPersonModel()
    @State var dataArray = NewPersonModel().Friends
    
    var body: some View {
        VStack{
            
            HStack{
                Spacer().frame(width: 263)
                Button(action: {
                    self.showModalSearch = true
                }, label: {
                    Image("Magnifier")
                }).sheet(isPresented: self.$showModalSearch){
                    SearchView(text: $searchText).presentationDetents([.fraction(0.75)])
                }
                
                editButton
                
            }
            Divider()
            NavigationView {
                List(selection: $selection) {
                    ForEach(data.Friends, id: \.self) { friend in
                        HStack{
                            Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
                                .foregroundColor(Color.random())
                            VStack(alignment: .leading) {
                                
                                Text(friend.nickName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text(friend.promise)
                                    .fontWeight(.semibold)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text(String(friend.stars)).frame(width: 25, height: 25, alignment: .leading)
                            
                        }.listRowSeparator(.hidden)
                    }.onDelete(perform: delete)
                }
                .listStyle(PlainListStyle())
//                .navigationBarItems(trailing: editButton)
                .environment(\.editMode, self.$editMode)
            }
        }
        
    }
    var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
                self.selection = Set<String>()
            }) {
                Image("Vector")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
                self.selection = Set<String>()
                deleteNumbers()
            }) {
                Image("so-trashred")
            }
        }
    }
    
    func deleteNumbers() {
        for id in selection {
            if let index = numbers.lastIndex(where: { $0 == id })  {
                numbers.remove(at: index)
            }
        }
        selection = Set<String>()
    }
    func delete(at offsets: IndexSet) {
            numbers.remove(atOffsets: offsets)
        }
}

//
//struct TrashView: View {
//
//    @State var numbers = ["Record1","Record2","Record3","Record4","Record5","Record6","Record1Seven","Record1Eight","Record1Nine","Record1Ten"]
//    @State var editMode = EditMode.inactive
//    @State var selection = Set<String>()
//    @ObservedObject var data = NewPersonModel()
//    @State var dataArray = NewPersonModel().Friends
//
//
//    var body: some View {
//        NavigationView {
//            List(selection: $selection) {
//                ForEach(data.Friends, id: \.self) { friend in
//                    HStack{
//                        Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
//                            .foregroundColor(Color.random())
//                        VStack(alignment: .leading) {
//
//                            Text(friend.nickName)
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                            Text(friend.promise)
//                                .fontWeight(.semibold)
//                                .font(.caption2)
//                                .foregroundColor(.gray)
//                        }
//                        Spacer()
//                        Image(systemName: "star.fill").foregroundColor(.yellow)
//                        Text(String(friend.stars)).frame(width: 25, height: 25, alignment: .leading)
//
//                    }.listRowSeparator(.hidden)
//                }.onDelete(perform: delete)
//            }
//            .listStyle(PlainListStyle())
//            .navigationBarItems(trailing: editButton)
//            .environment(\.editMode, self.$editMode)
//        }
//    }
//    var editButton: some View {
//        if editMode == .inactive {
//            return Button(action: {
//                self.editMode = .active
//                self.selection = Set<String>()
//            }) {
//                Image("Vector")
//            }
//        }
//        else {
//            return Button(action: {
//                self.editMode = .inactive
//                self.selection = Set<String>()
//                deleteNumbers()
//            }) {
//                Image("so-trashred")
//            }
//        }
//    }
//
//    func deleteNumbers() {
//        for id in selection {
//            if let index = numbers.lastIndex(where: { $0 == id })  {
//                numbers.remove(at: index)
//            }
//        }
//        selection = Set<String>()
//    }
//    private func delete(at offsets: IndexSet) {
//            numbers.remove(atOffsets: offsets)
//        }
//}
//

struct ScrollVertical: View{
    
    @ObservedObject var data = NewPersonModel()
    @State var editMode = EditMode.inactive
    @State var selection = Set<String>()
    
    
    var body: some View {
        
        //        NavigationView {
        ZStack(alignment: .bottomTrailing){
            Rectangle().frame(height: 0)
            //                NavigationView{
            List(data.Friends, id: \.self){ friend in //selection: $selection, 추가해야함 **
                //                        ForEach(data.Friends){ friend in
                HStack{
                    Image(systemName: "person.circle.fill").resizable().frame(width: 37, height: 37)
                        .foregroundColor(Color.random())
                    VStack(alignment: .leading) {
                        
                        Text(friend.nickName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(friend.promise)
                            .fontWeight(.semibold)
                            .font(.caption2)
                            .foregroundColor(.gray)
                        
                    }
                    Spacer()
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text(String(friend.stars)).frame(width: 25, height: 25, alignment: .leading)
                    
                }.listRowSeparator(.hidden)
                
                //                        }
                //                    .onDelete { index in
                //                    }
                
            }
            //                    .navigationBarItems(leading: deleteButton, trailing: editButton)
            //                    .environment(\.editMode, self.$editMode)
            .listStyle(PlainListStyle())
            
            Button(action: {
                print("Floating Button Click")
            }, label: {
                NavigationLink(destination: FriendSearchView()) {
                    Image("Group 65").frame(width: 51, height: 51, alignment: .bottomTrailing)
                }
            })
        }
    }
    private var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
                self.selection = Set<String>()
            }) {
                Image("Vector")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
                self.selection = Set<String>()
            }) {
                Image("so-trashred")
            }
        }
    }
}
//    }
//    private var editButton: some View {
//        if editMode == .inactive {
//            return Button(action: {
//                self.editMode = .active
//                self.selection = Set<String>()
//            }) {
//                Text("Edit")
//            }
//        }
//        else {
//            return Button(action: {
//                self.editMode = .inactive
//                self.selection = Set<String>()
//            }) {
//                Text("Done")
//            }
//        }
//    }
//
//    private var deleteButton: some View {
//        if editMode == .inactive {
//            return Button(action: {}) {
//                Image(systemName: "")
//            }
//        } else {
//            return Button(action: deleteNumbers) {
//                Image(systemName: "trash")
//            }
//        }
//    }
//
//    private func deleteNumbers() {
//        for id in selection {
//            if let index = names.lastIndex(where: { $0 == id })  { //변경해야함
//                model.people.remove(at: index)
//            }
//        }
//        selection = Set<String>()
//    }
//}



struct BetterMeView: View{
    
    var body: some View{
        Rectangle().frame(height: 0)
        Button(action: {
            print("홈으로 이동")
        }, label: {
            Image("BetterMe")
                .padding(.top, 17.0).padding(.leading, 18).padding(.bottom, 28)
        })
    }
    
}



struct ContentView: View {
    
    @State var tabIndex = 0
    @Namespace var animation
    
    var body: some View {
        
        NavigationView() {
            VStack(alignment: .leading){
                Rectangle().frame(height: 0)
                Button(action: {
                    print("홈으로 이동")
                }, label: {
                    Image("BetterMe")
                        .padding(.top, 17.0).padding(.leading, 18).padding(.bottom, 28)
                })
                
                VStack{
                    CustomTopTabBar(tabIndex: $tabIndex)
                    if tabIndex == 0 {
                        FriendView()
                    }
                    else if tabIndex == 1 {
                        SecondView()
                    }
                    else if tabIndex == 2{
                        ThirdView()
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
                .padding(.horizontal, 12).tabItem{
                    Image(systemName: "medal")

                }
            }
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            FriendView()
            ContentView()
            FriendSearchView()
        }
    }
}
