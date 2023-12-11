//
//  MyLikeView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/11.
//

import SwiftUI

struct MyLikeView : View {
    @ObservedObject var likeVM = LikeViewModel()
    
    var body: some View {
        var likes = likeVM.likeStores
        ScrollView{
            
            ForEach(likes , id : \.self ) { like in
                ForEach(like.stores , id: \.self){ store in
                    
                    LikeListView(storeData: store)
                }
                
                
                //Divider().background(Color.red)
            }
        }
        .background(Color(hex: 0xEFEFEF))
        .padding(.bottom , 50)
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


struct MyLikeView_Previews: PreviewProvider {
    static var previews: some View {
        
        MyLikeView()
    }
}
