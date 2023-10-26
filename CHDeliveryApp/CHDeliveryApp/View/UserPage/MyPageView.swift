//
//  MyPageView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/03.
//

import SwiftUI

struct MyPageView : View {
    @ObservedObject var homeState : HomeState
    @ObservedObject var userVM : UserViewModel
    
    @State private var tag:Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(hex: 0xEFEFEF).ignoresSafeArea()

            
                HStack {
                    ScrollView {
                            
                        ZStack {
                            NavigationLink(destination: EditUserView(homeState : homeState , userVM: userVM) , tag: 2, selection: self.$tag ) {
                              EmptyView()
                            }
                            NavigationLink(destination: MyStoreRegisterView(homeState : homeState ) , tag: 3, selection: self.$tag ) {
                              EmptyView()
                            }

                            
                            VStack{
                                HStack{
                                    //동그란 프로필 사진
                                    if userVM.users.first == nil{
                                        Image("userDefault")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 100))
                                    }else{
                                        
                                        //let userImage2 = UIImage(data: userVM.getImage() as! Data)
                                        //let image2 = Image(uiImage: userImage2!)
                                        //image2
                                        userVM.imageInit()
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .clipShape(RoundedRectangle(cornerRadius: 100))
                                        
                                    }

                                    // 닉네임
                                    Button(action: {
                                        self.tag = 2
                                    },
                                        label: {
                                            HStack{
                                                if userVM.users.first == nil {
                                                    Text("닉네임 설정 해주세요")
                                                }else{
                                                    Text(userVM.getname())
                                                }
                                                
                                                Image(systemName: "chevron.right")
                                        }
                                    }).foregroundColor(Color.black)
                                    
                                }.padding()
                                
                                HStack{
                                    Spacer()
                                    VStack{
                                        Image(systemName: "scroll")
                                        Text("주문 내역")
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "heart.fill").foregroundColor(Color.red)
                                        Text("나의 찜")
                                    }
                                    Spacer()
                                    VStack{
                                        Image(systemName: "paintbrush.pointed.fill")
                                        Text("리뷰 관리")
                                    }
                                    Spacer()
                                }
                                
                                
                            }.frame(width: 350, height: 200)
                            .background(Color.white)
                            .cornerRadius(15)
                        .padding()
                        }
                        
                        VStack{
                            HStack{
                                Spacer()

                                Button(action: {self.tag = 3}, label: {
                                    VStack{
                                        Image(systemName: "house.fill").foregroundColor(Color.mint)
                                        Text("My 가게 등록") }}).foregroundColor(Color.black)
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    VStack{
                                    Image(systemName: "mail.stack").foregroundColor(Color.mint)
                                        Text("My 가게 관리") }}).foregroundColor(Color.black)
                                
                                Spacer()
                                
                            }
                            
                            
                        }.frame(width: 350, height: 100)
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding()
                        
                    }
                }//ScrollView
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        } //NavigationView

    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(homeState: HomeState() , userVM: UserViewModel())
    }
}
