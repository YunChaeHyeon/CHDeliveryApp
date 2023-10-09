//
//  CartView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/21.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var homeState : HomeState
    @StateObject var CartVM = CartViewModel()
    @Environment(\.dismiss) private var dismiss
    
//    init(){
//        CartVM = CartViewModel()
//    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                
                //forEach in i > CartShop
                CartShop(CartVM: CartVM)

                VStack{
                    //총 주문금액
                    //배달팁
                    
                    //결제 예정 금액
                }

            
            } .background(
                VStack(spacing: .zero) {
                    Color.white
                        .frame(height : 100)
                        Color(hex: 0xEFEFEF)
            })
            .onAppear(perform: {
                    homeState.isHiddenTap()
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {

                                // 2
                                ToolbarItem(placement: .navigationBarLeading) {
                                    HStack{
                                        Button {
                                            homeState.isVisibilityTap()
                                            dismiss()

                                        } label: {
                                            HStack {
                                                Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                            }
                                        }
                                }
                            }//ToolbarItem
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { } , label: {
                                Image(systemName: "house.circle").resizable().frame(width: 30, height: 30)
                            }).foregroundColor(Color.black)

                        }
               }// toolbar
            
            //Cart In Button
            CartOrderButton(CartVM: CartVM)
        } //ZStack
        
    }
}

struct CartOrderButton : View {
    @StateObject var CartVM : CartViewModel
    var body: some View {
        HStack{

                Button(action: {}, label: {
                    HStack{
                        Text("배달 주문하기")
                        Text("\(CartVM.Total)원")
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.mint)
                    .cornerRadius(15)
                    .padding(10)


                
        } //HStack
        .background(Color.white)
    }
}

struct CartShop : View {
    @StateObject var CartVM : CartViewModel
    
    var body: some View {
        VStack {
            //가게 이름 & 30~ 40분 후 도착
            HStack{
                Text("가게 이름")
                Spacer()
                Text("30~40분 후 도착")
                
            }.padding()
            
            Divider()
            // 메뉴이름
            HStack{
                Text("메뉴 이름")
                Spacer()
                Button(action: {}, label: { Image(systemName: "xmark").foregroundColor(Color.black)})
            }.padding()
            
            // 사진 & 가격 : 17000원
            HStack{
                Image("food/food1").frame(width: 100, height: 100)
                VStack(alignment: .leading){
                    Text("가격 : \(CartVM.Price)원")
                    Text("\(CartVM.Total)원")
                }.padding()
                Spacer()
            }.padding(20)
            
            //수량
            HStack{
                Spacer()
                HStack{
                    //Spacer()
                    Button(action: {
                        CartVM.DownCount()
//                        if(Count < 2) {return}
//                        Count = Count - 1
//                        Total = Count*Price
                    }, label: {Image(systemName: "minus")})
                        .padding(.trailing,10)
                    
                    Text("\(CartVM.Count)")
                    
                    Button(action: {
                        CartVM.UpCount()
//                        Count = Count + 1
//                        Total = Count*Price
                    }, label: {Image(systemName: "plus")})
                        .padding(.leading , 10)
                }
                .frame(width: 110 , height: 40)
                .foregroundColor(Color.black)
                    //.padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.padding(20)


        }.background(Color.white)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(homeState: HomeState(), CartVM: CartViewModel())
        //CartView()
    }
}
