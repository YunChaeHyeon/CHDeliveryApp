//
//  MyStoreEditView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/13.
//

import SwiftUI

struct MyStoreEditView : View {
    @ObservedObject var storeVM : StoreViewModel
    var storeData : Store
    
    var body : some View {
        var menus = storeVM.menus
        MyStoreRegisterView(storeVM : storeVM ,homeState: HomeState(), isRegister: false, storeData: storeData , isEdit: true)

    }

}

struct MyStoreListView : View {
    @ObservedObject var homeState : HomeState
    @Environment(\.dismiss) private var dismiss
    @State private var tag:Int? = nil
    
    @ObservedObject var storeVM : StoreViewModel = StoreViewModel()
    var imageconversion : ImageConversion = ImageConversion()
    
    var body: some View {
        let stores = storeVM.stores
        ScrollView{
            ForEach( Array(stores.enumerated()) , id: \.offset){ storeIndex, store in
                NavigationLink( destination: MyStoreEditView(storeVM : storeVM ,storeData: storeVM.findStoreData(storeName: store.storeName))  , tag: store.hashValue , selection: self.$tag , label: {
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
                                Spacer()
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.red)
                                    .onTapGesture{
                                        storeVM.delViewModelStore(removeIndex: storeIndex)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            storeVM.FindDelStore(storeName: store.storeName)
                                        }
                                        print("\(store.storeName) 삭제")
                                    }
                            }.font(.system(size: 14))
                            Text("최소주문 \(store.minDelivery)원")
                                .font(.system(size: 14))
                        }.foregroundColor(Color.black)
                            .padding(10)

                        Spacer()
                    }
                })
                    .onAppear{
                        storeVM.storeName = store.storeName
                        storeVM.storeCategory = store.storeCategory
                        storeVM.payMethod = store.payMethod
                        storeVM.minDelivery = store.minDelivery
                        storeVM.minTime =  store.minTime
                        storeVM.tip = store.tip
                    }
                    .background(Color.white)
                    .cornerRadius(8.0)

            }
        }//ScrollView
        .padding(.top , 20)
        .padding(.horizontal , 20)
        .background(Color(hex: 0xEFEFEF))
        .onAppear(perform: {
                homeState.isHiddenTap()
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
        .toolbar {

                        // 2
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack{
                                Button {
                                    homeState.isVisibilityTap()
                                    dismiss()

                                } label: {
                                    // 4
                                    HStack {
                                        Image(systemName: "chevron.backward").foregroundColor(Color.black)
                                        Text("내 가게 리스트").foregroundColor(Color.black)

                                    }
                                 }
                            }
                       }//ToolbarItem.
            }
        .navigationBarBackground({
            Color.white
    })
    }
}

