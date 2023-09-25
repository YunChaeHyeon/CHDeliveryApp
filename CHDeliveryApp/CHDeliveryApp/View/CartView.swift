//
//  CartView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/21.
//

import SwiftUI
struct CartView: View {
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
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
                            Text("가격 : 17,000원")
                            Text("17,000원")
                        }.padding()
                        Spacer()
                    }.padding(20)
                    
                    //수량
                    HStack{
                        Spacer()
                        HStack{
                            //Spacer()
                            Button(action: {}, label: {Image(systemName: "minus")})
                                .padding(.trailing,10)
                            
                            Text("1")
                            
                            Button(action: {}, label: {Image(systemName: "plus")})
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
            .navigationBarBackButtonHidden(true)
            .toolbar {

                                // 2
                                ToolbarItem(placement: .navigationBarLeading) {
                                    HStack{
                                        Button {
                                            print("Custom Action")
                                            dismiss()

                                        } label: {
                                            // 4
                                            HStack {
                                                Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                                Text("배달").foregroundColor(Color.black)
                                                Image("rice").resizable().frame(width: 20, height: 20)
                                            }
                                        }
                                }
                            }//ToolbarItem
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { } , label: {
                                Image(systemName: "cart").resizable().frame(width: 20, height: 20)
                            }).foregroundColor(Color.black)

                        }
               }// toolbar
            
            //Cart In Button
            HStack{

                    Button(action: {}, label: {
                        HStack{
                            //Text("\(total)")
                            Text("원 담기")
                        }
                        .font(.system(size:20 , weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(width: 250, height: 50)
                    }).background(Color.mint)
                        .cornerRadius(15)
                        .padding(10)


                    
            } //HStack
            .background(Color.white)
        } //ZStack
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
