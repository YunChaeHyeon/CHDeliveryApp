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
    
    var body: some View {
        var carts = CartVM.carts
        ZStack(alignment: .bottom) {
            ScrollView{
                
                ForEach( Array(carts.enumerated()) , id: \.offset){ idx,cart in
                    CartShop(cart , CartVM , idx)
                    
                }

                VStack{
                    //총 주문금액
                    //배달팁
                    
                    //결제 예정 금액
                }

            
            }
            .padding(.bottom , 70)
            .background(
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
                        Text("\(CartVM.total)원")
                    }
                    .font(.system(size:20 , weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 250, height: 50)
                }).background(Color.mint)
                    .cornerRadius(15)
                    .padding(10)


                
        } //HStack
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

struct CartShop : View {
    var cartData : Cart
    @StateObject var CartVM : CartViewModel
    var cartIndex : Int
    
    init(_ cart : Cart , _ CartVM : CartViewModel , _ cartIndex : Int ){
        self.cartData = cart
        _CartVM = StateObject(wrappedValue: CartVM)
        self.cartIndex = cartIndex
    }
    
    var body: some View {
        VStack {
            //가게 이름 & 30~ 40분 후 도착
            HStack{
                Text("\(cartData.storeName)")
                Spacer()
                Text("\(cartData.deliveryTime)분 후 도착 예정")
                
            }.padding()
            
            Divider()
            // 메뉴이름
            ForEach( Array(cartData.cartMenus.enumerated()), id: \.offset){ idx , Menu in
                CartMenuView(cartData: cartData, CartVM: CartVM, cartMenu: Menu , cartIndex : cartIndex , cartMenuIndex : idx )
            }


        }.background(Color.white)
    }
}

struct CartMenuView : View {
    var cartData : Cart
    @ObservedObject var CartVM : CartViewModel
    var cartMenu : CartMenu
    var imageconversion : ImageConversion = ImageConversion()
    var cartIndex : Int
    var cartMenuIndex : Int
    @State var total = 0
    @State var count = 1
    @State var price = 0
    
    func UpCount(){
        count = count + 1
        total = price*count
        print("count : \(count) price : \(price)")
        print("total : \(total)")
    }

    func DownCount(){
        if(count < 2) {return}
        count = count - 1
        total = price*count
    }
    
    var body: some View {
        HStack{
            Text("\(cartMenu.menuName)")
            Spacer()
            Button(action: {
               
                if(cartData.cartMenus.count == 1){
                    CartVM.delViewModelCart(removeIndex: cartIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        CartVM.delCart(old: cartData)
                    }
                }else{
                    CartVM.delViewModelCartMenu(cartIndex: cartIndex, removeMenuIndex: cartMenuIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        CartVM.delCartMenu(obj: cartMenu)
                    }
                }
                
                CartVM.objectWillChange.send()
        
            }, label: { Image(systemName: "xmark").foregroundColor(Color.black)})
        }.padding()
        
        // 사진 & 가격 : 17000원
        HStack{
            imageconversion.getImage(_image: cartMenu.menuImage!)
                .resizable()
                .frame(width: 100, height: 100)

            VStack(alignment: .leading){
                Text("가격 : \(cartMenu.price)원")
                Text("총 가격 : \(total)원")
            }.padding()
            Spacer()
        }.padding(20)
         .onAppear(){
             price = cartMenu.price
             count = cartMenu.count
             total = price * count 
         }
        
        //수량
        HStack{
            Spacer()
            HStack{
                //Spacer()
                Button(action: {
                    DownCount()
                }, label: {Image(systemName: "minus")})
                    .padding(.trailing,10)
                
                Text("\(count)")
                
                Button(action: {
                    UpCount()
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
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(homeState: HomeState())
        //CartView()
    }
}
