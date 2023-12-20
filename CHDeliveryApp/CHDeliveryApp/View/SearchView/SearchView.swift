//
//  SearchView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/12.
//

import SwiftUI
 
struct SearchView: View {
    
    @ObservedObject var homeState : HomeState
    @State private var tag:Int? = nil
    
    @ObservedObject var StoreVM : StoreViewModel = StoreViewModel()
    var imageconversion : ImageConversion = ImageConversion()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                ScrollView {
                    ForEach(StoreVM.stores.filter{$0.storeName.contains(searchText) || searchText == "" } , id: \.self ) { store in
                        NavigationLink( destination : ShopView(store , homeState) , tag: store.hashValue , selection: self.$tag , label: {
                            HStack{
                                imageconversion.getImage(_image: store.storeMainImage!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100)
                                    .padding(.trailing , 20)
                                
                                VStack(alignment: .leading){
                                    Text("\(store.storeName)")
                                        .font(.system(size: 20 , weight: .bold))
                                    HStack{
                                        Text("배달 \(store.minTime)분")
                                            .padding(.trailing, 5)
                                        Text("배달팁 \(store.tip)")
                                    }
                                    Text("최소주문 \(store.minDelivery)원")
                                    
                                }.foregroundColor(Color.black)
                                    .padding(10)

                                Spacer()
                            }
                            .background(Color.white)
                        })
                        
                    }//ForEach

                } //리스트의 스타일 수정
                .listStyle(PlainListStyle())
                .background(Color(hex: 0xEFEFEF))
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                    HStack{
                Image(systemName: "sparkle.magnifyingglass").foregroundColor(Color.cyan)
                        Text("가게 찾기")
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
        }//NavigationView
        .background(Color(hex: 0xEFEFEF))
    }
}

