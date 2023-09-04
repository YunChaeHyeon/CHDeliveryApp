//
//  Test.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/04.
//

import SwiftUI


struct TestView: View {
    var body: some View {
//        ScrollView{
//            Image("food/food2").resizable().frame(width:50 , height: 40)
//            Text("Hello CH ~ !")
//                .background(Color.red)
//        }
        VStack(spacing: 0){
            HStack{
                Image("Shop/Shop0").resizable().frame(width: 100, height: 120 ,alignment: .leading)
                Spacer()
                VStack{
                    //Text("")
                    //Shop Tilte
                    Text("Food1").font(.system(size: 20 , weight: .bold))
                        //.padding()
                }
                Spacer()
            }
            HStack{
                Image("Shop/Shop0").resizable().frame(width: 100, height: 120 ,alignment: .leading)
                Spacer()
                VStack{
                    //Text("")
                    //Shop Tilte
                    Text("Food1").font(.system(size: 20 , weight: .bold))
                        //.padding()
                }
                Spacer()
            }
        }

        


    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

