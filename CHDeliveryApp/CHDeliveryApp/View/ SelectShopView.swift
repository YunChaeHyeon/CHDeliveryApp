//
//   SelectShopView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/09.
//

import SwiftUI

struct SelectShopView: View {
    @State var tabIndex : Int
    @Environment(\.dismiss) private var dismiss
    @State private var tag:Int? = nil
    @ObservedObject var storeRegiVM = StoreRegisterViewModel()
    
    var body: some View {
        VStack{
            VStack{
                
                CustomTopTabBar(tabIndex: $tabIndex)
                    .padding(.bottom, -7)
                
                CustomerSelectionView()
                
               
            }.background(Color.white)
            ScrollView{
                
                CategoryShopView(storeRegiVM: storeRegiVM, topTapNum: tabIndex).background(Color.white)
                
                Spacer(minLength: 100)
            }.background(Color(hex: 0xEFEFEF))
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
                        NavigationLink(destination: CartView(homeState:  HomeState() ,CartVM: CartViewModel()) , tag: 1, selection: self.$tag , label: {
                            Button(action: {self.tag = 1} ) {
                                Image(systemName: "cart")
                                    .foregroundColor(Color.black)
                            }
                        })

                        }
                    }
        }.background(Color(hex: 0xEFEFEF))
    
    }
}

struct CustomTopTabBar: View {
    
    var Foods : Category = Category()
    
    @Binding var tabIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20) {
                ForEach(0..<14){
                    i in TabBarButton(text: "\(Foods.foodName[i])", isSelected: .constant(tabIndex == i))
                        .onTapGesture { onButtonTapped(index: i) }
                }
                Spacer()
            }
        }

        .border(width: 1, edges: [.bottom], color: .black)
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
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}



extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct storeView : View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    var storeData : Store
    
    init(_ storeRegiVM : StoreRegisterViewModel , _ storeData : Store){
        self.storeRegiVM = storeRegiVM
        self.storeData = storeData
    }
    
    var body: some View {
        
        HStack{
            storeRegiVM.getStoreImage(store: storeData)
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

            Spacer()
        }.padding(10)
    }
}

struct storeListView: View {
    
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    var storeData : Store
    var categoryName : String
    var topTapNum : Int
    init(_ storeRegiVM : StoreRegisterViewModel ,_ storeData : Store , _ categoryName : String , _ topTapNum : Int){
        self.storeRegiVM = storeRegiVM
        self.storeData = storeData
        self.categoryName = categoryName
        self.topTapNum = topTapNum
    }
    
    var body: some View {
        
        HStack {
            switch(topTapNum){
            case 0:
                if(categoryName == "족발 보쌈"){
                    storeView(storeRegiVM, storeData)
                }
            case 1:
                if(categoryName == "찜 탕 찌개"){
                    storeView(storeRegiVM, storeData)
                }
            case 2:
                if(categoryName == "일식"){
                    storeView(storeRegiVM, storeData)
                }
            case 3:
                if(categoryName == "피자"){
                    storeView(storeRegiVM, storeData)
                }
            case 4:
                if(categoryName == "고기"){
                    storeView(storeRegiVM, storeData)
                }
            case 5:
                if(categoryName == "야식" ){
                    storeView(storeRegiVM, storeData)
                }
            case 6:
                if(categoryName == "양식") {
                    storeView(storeRegiVM, storeData)
                }
            case 7:
                if(categoryName == "치킨") {
                    storeView(storeRegiVM, storeData)
                }
            case 8:
                if(categoryName == "중식") {
                    storeView(storeRegiVM, storeData)
                }
            case 9:
                if(categoryName == "백반") {
                    storeView(storeRegiVM, storeData)
                }
            case 10:
                if(categoryName == "도시락") {
                    storeView(storeRegiVM, storeData)
                }
            case 11:
                if(categoryName == "분식") {
                    storeView(storeRegiVM, storeData)
                }
            case 12:
                if(categoryName == "패스트푸드") {
                    storeView(storeRegiVM, storeData)
                }
            case 13:
                if(categoryName == "아시안") {
                    storeView(storeRegiVM, storeData)
                }
            default:
                Text("")
            }
        }
    }
}

struct CategoryShopView : View {
    
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    @State private var tag:Int? = nil
    var Foods : Category = Category()
    var topTapNum : Int
    var body: some View {
        var stores = storeRegiVM.stores
        VStack {
            ForEach(stores , id : \.self) { store in
                NavigationLink( destination: ShopView(store)  , tag: store.hashValue , selection: self.$tag , label: {
                    storeListView(storeRegiVM ,store , store.storeCategory , topTapNum)
                })
                
            }
        }
    }
}


//struct SelectShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectShopView(tabIndex: 0)
//    }
//}

