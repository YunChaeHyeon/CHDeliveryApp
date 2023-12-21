//
//  MyLikeView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/11.
//

import SwiftUI

struct MyLikeView : View {
    @ObservedObject var homeState : HomeState
    @ObservedObject var likeVM = LikeViewModel()
    @State private var tag:Int? = nil
    @State var isVisible = false 
    
    var body: some View {
        var likes = likeVM.likeStores
        NavigationView {
            ScrollView{
                
                ForEach( likes , id : \.id ) {like in
                    ForEach(like.stores , id: \.id){ store in
                        NavigationLink( destination : ShopView( id : store.id ,storeData: store , homeState: homeState , isSelectView: false).onAppear{
                            homeState.isHiddenTap()
                        } , tag: like.hashValue , selection: self.$tag , label: {
                            LikeListView(storeData: store)
                        })
                        
                    }
                }
                .opacity(!isVisible ? 0:1)
                .onAppear{
                    isVisible = false
                        withAnimation(.easeInOut(duration: 0.5)){
                            isVisible = true
                        }
                }
                
            }
            .listStyle(PlainListStyle())
            .background(Color(hex: 0xEFEFEF))
            .padding(.bottom , 50)
            .padding(.top , 30)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                    HStack{
                        Image(systemName: "heart.fill").foregroundColor(Color.red)
                        Text("찜 리스트")
                    }.padding(.top , 20)
                                    .font(.system(size: 20 , weight: .bold ))
            )
              .navigationBarItems(trailing:
                                        HStack{
                                            Button(action: {
                                            }) {
                                                HStack {
                                                    NavigationLink(destination: CartView(homeState: homeState) , tag: 1, selection: self.$tag , label: {
                                                        Button(action: {self.tag = 1} ) {
                                                            Image(systemName: "cart")
                                                                .foregroundColor(Color.mint)
                                                        }
                                                    })
                                                }
                                            }
                                        }
                )
        
        }.background(Color(hex: 0xEFEFEF))
    }
}

struct LikeListView : View {
    var imageconversion : ImageConversion = ImageConversion()
    var storeData : Store
    
    var body: some View {
        HStack{
            imageconversion.getImage(_image: storeData.storeMainImage!)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: 100, height: 100)
                .padding(.trailing , 20)
            
            VStack(alignment: .leading){
                Text("\(storeData.storeName)")
                    .font(.system(size: 20 , weight: .bold))
                HStack{
                    Text("배달 \(storeData.minTime)분")
                        .padding(.trailing, 5)
                    Text("배달팁 \(storeData.tip)")
                }
                Text("최소주문 \(storeData.minDelivery)원")
                
            }.foregroundColor(Color.black)
                .padding(10)

            Spacer()
        }
        .background(Color.white)
        
    }
}

