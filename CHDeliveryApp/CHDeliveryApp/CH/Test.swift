//
//  Test.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/04.
//

import SwiftUI


struct TestView: View {
    var body: some View {
        ScrollView{
            Image("food/food2").resizable().frame(width:50 , height: 40)
            Text("Hello CH ~ !")
                .background(Color.red)
        }

    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

