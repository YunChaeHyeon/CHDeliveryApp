//
//  SelectMenuView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/11.
//

import SwiftUI


struct SelectMenuView: View {
    var Menuitems = ["소", "중", "대","CH","CH2"]
    var Menuprice = [1000,2000,3000,5000,10000]
    @State var selectedString = ""
    @State var checkMenu = [""]
    @State var checkbool = false
    @State var total = 25000
    @State var _lastPrice = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                VStack(alignment: .leading){
                    Text("New 메뉴이름").font(.system(size:20 , weight: .bold))
                    Spacer()
                    HStack{
                        Text("가격")
                        Spacer()
                        Text("25,000")
                    }.font(.system(size: 18,weight: .bold))
                }.padding(50)
                    .background(Color.white)
                
                //Radio Button !
                VStack(alignment: .leading){
                    Text("Title")
                    RadioButtonGroup(items: Menuitems, Menuprice: Menuprice, MenulastPrice: _lastPrice,selectedId: Menuitems[0]) { selected,price,lastPrice in
                            //print("Selected is: \(selected)")
                        _lastPrice = lastPrice
                            total = total - _lastPrice
                            total = total + price
                            selectedString = selected
                        }
                    //Text("lastPrice : \(_lastPrice)")
                    //Text("You selected: \(selectedString)")
                }.background(Color.white)
                    .padding(.bottom , 1)
                
                //check box Button !
                VStack(alignment: .leading){
                    //Text("you checkbool? : \(String(checkbool))")
                   //Text("you checkMenu: \(checkMenu[0])")
                    
                    Text("Title")
                    CheckboxGroup(items: Menuitems , Menuprice: Menuprice){ Menu,price,isputCart  in
                        print("\(Menu) call , \(isputCart) call2")
                        if(isputCart == true){
                            total = total + price
                        }else{
                            total = total - price
                        }
                        //checkMenu = call
                        checkbool = isputCart
                    }

                }.background(Color.white)
            
                
            } // ScrollView
            .background(
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
            .navigationBarBackground({
                Color.white
            })
            
            //Cart In Button
            HStack{
                VStack{
                    Text("배달 최소 주문 금액").foregroundColor(Color.gray)
                    Text("24,000")
                }.padding(.leading ,5)
                Spacer()
                    Button(action: {}, label: {
                        HStack{
                            Text("\(total)")
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

struct CheckboxGroup: View {
    let items : [String]
    let Menuprice : [Int]
    let callback: (String,Int,Bool)->()

    var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                CheckboxField(self.items[index], self.items[index], self.Menuprice[index],size: 14 ,callback: self.checkGroupCallback)
            }
        }
    }
    
    func checkGroupCallback(id: String, price: Int,isMasrked: Bool) {
        callback(id, price ,isMasrked)
    }
    
}

struct CheckboxField: View {
    let id: String
    let label: String
    let price: Int
    let size: CGFloat
    let callback: (String, Int,Bool)->()
    let color: Color
    let textSize: Int

    
    init(
        _ id: String,
        _ label:String,
        _ price: Int,
        size: CGFloat = 10,
        callback: @escaping (String, Int,Bool)->(),
        color: Color = Color.black,
        textSize: Int = 14

        ) {
        self.id = id
        self.label = label
        self.price = price
        self.size = size
        self.color = color
        self.textSize = textSize
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.price ,self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: size))
                Spacer()
               
                Text("+\(price)원")
                
            }.foregroundColor(self.color)
                .padding(15)
        }
        .foregroundColor(Color.white)
    }
}

struct RadioButtonGroup: View {

    let items : [String]
    let Menuprice : [Int]
    let MenulastPrice: Int

    @State var selectedId: String = ""
    @State var _price: Int = 0
    @State var _lastPrice: Int = 0
    
    let callback: (String,Int,Int) -> ()

    var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], self.Menuprice[index], _lastPrice , callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
    }

    func radioGroupCallback(id: String , price: Int ,  lastPrice: Int) {
        selectedId = id
        _price = price
        _lastPrice = _price
        callback(id,price,lastPrice)
    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: String
    let price: Int
    let lastPrice: Int
    let callback: (String,Int,Int)->()
    let selectedID : String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ id: String,
        _ price: Int,
        _ lastPrice: Int,
        callback: @escaping (String,Int,Int)->(),
        selectedID: String,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.id = id
        self.price = price
        self.lastPrice = lastPrice
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.callback = callback
    }

    var body: some View {
        Button(action:{
            self.callback(self.id , self.price, self.lastPrice)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == self.id ? "circle.circle.fill" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .modifier(ColorInvert())
                Text(id)
                    .font(Font.system(size: textSize))
                Spacer()
                HStack{
                    Text("+\(price)원")
                }
                
            }.foregroundColor(self.color)
                .padding(15)
        }
        .foregroundColor(self.color)
    }
}

struct ColorInvert: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                content
            }
        }
    }
}

struct SelectMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMenuView()
    }
}
