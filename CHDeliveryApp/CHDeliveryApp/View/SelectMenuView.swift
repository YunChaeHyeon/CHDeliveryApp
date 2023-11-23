//
//  SelectMenuView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/11.
//

import SwiftUI


struct SelectMenuView: View {
    var Menuitems = ["소", "중", "대"]
    var Menuprice = [1000,2000,3000]
    
    @ObservedObject var cartVM : CartViewModel
    
    var MenuItem : Menu
    @State var checkMenu = [""]
    @State var checkbool = false
    @State var total = 0
    @State var _lastPrice = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                VStack(alignment: .leading){
                    Text("\(MenuItem.menuName)").font(.system(size:20 , weight: .bold))
                    Spacer()
                    HStack{
                        Text("가격")
                        Spacer()
                        Text("\(MenuItem.menuDefaultPrice)")
                    }.font(.system(size: 18,weight: .bold))
                }.padding(50)
                    .background(Color.white)
                
                //Radio Button !
                VStack(alignment: .leading){

                    ForEach(MenuItem.menuRequired , id: \.self){ menuRequ in
                        Text("\(menuRequ.menuRequitedTilte)")
                        RadioButtonGroup(MenuRe : menuRequ , _lastPrice: _lastPrice) { selected in
                        } priceCallback: {
                            price , last in
                             total = total + price
                        }
                    }

                }.background(Color.white)
                    .padding(.bottom , 1)
                
                //check box Button !
                Group{
                    VStack(alignment: .leading){
                        ForEach(MenuItem.menuOptions, id:\.self){ menuOption in
                            Text("\(menuOption.menuOptionsTilte)")

                            CheckboxGroup(items: Menuitems , Menuprice: Menuprice, MenuOp: menuOption){ Menu,price ,checkOption in
                                print("checkOption : \(checkOption)")
                                if(checkOption){
                                    total = total + price
                                }else{
                                    total = total - price
                                }
                            }

                        }

                    }.background(Color.white)
                }

            
                
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
            CartIn(total: $total)
        } //ZStack


    }
}

struct CartIn : View {
    @Binding var total : Int
    var body: some View {
        
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
    }
}

struct CheckboxGroup: View {
    let items : [String]
    let Menuprice : [Int]
    var MenuOp : MenuOption
    let callback: (String,Int,Bool)->()

    var body: some View {
        VStack {

            ForEach(MenuOp.menuOptionList , id: \.self) { menuOpList in
                CheckboxField(menuOpList.menuOptionTitle , menuOpList.menuOptionTitle , menuOpList.menuPrice ,size: 17, callback: self.checkGroupCallback )
            }
        }
    }
    
    func checkGroupCallback(id: String, price: Int , checkOption: Bool) {
        callback(id, price ,checkOption)
    }
    
}

struct CheckboxField: View {
    let id: String
    let label: String
    let price: Int
    let size: CGFloat
    let callback: (String, Int ,Bool)->()
    let color: Color
    let textSize: Int
    
    init(
        _ id: String,
        _ label:String,
        _ price: Int,
        size: CGFloat = 10,
        callback: @escaping (String, Int ,Bool)->(),
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
    
    @State private var checkOption = false
    
    var body: some View {
        VStack{
            
            Button(action:{
                self.checkOption.toggle()
                self.callback(self.id, self.price , self.checkOption)
                print("under check : \(checkOption)")
            }) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName:  checkOption ? "checkmark.square" : "square")
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
}

struct RadioButtonGroup: View {

    var MenuRe : MenuRequired
    @State var _lastPrice: Int
    
    @State var selectedId : Int = 0
    @State var _price: Int = 0
    
    let idCallback: (Int) -> ()
    let priceCallback : (Int,Int) -> ()

    var body: some View {
        VStack {

            ForEach(Array(MenuRe.menuRequiredList.enumerated()) , id:\.offset){ idx, menuReList in
                RadioButton(menuReList.menuRequiredTitle ,idx , menuReList.menuPrice, _lastPrice , idCallback: self.radioGroupCallback , priceCallback: self.lastpriceCallback , selectedID: self.selectedId)
            }
        }
    }

    func radioGroupCallback(id: Int ) {
        idCallback(id)
        selectedId = id
    }
    
    func lastpriceCallback(price: Int , lastPrice: Int){
        _price =  price - _lastPrice
         priceCallback(_price , _lastPrice)
        _lastPrice = price

    }
}

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let menuName : String
    let id: Int
    let price: Int
    var lastPrice: Int
    let idCallback: (Int)->()
    let priceCallback: (Int,Int) -> ()
    let selectedID : Int
    let size: CGFloat
    let color: Color
    let textSize: CGFloat

    init(
        _ menuName : String ,
        _ id: Int,
        _ price: Int,
        _ lastPrice: Int,
        idCallback: @escaping (Int)->(),
        priceCallback: @escaping (Int,Int) ->(),
        selectedID: Int,
        size: CGFloat = 20,
        color: Color = Color.primary,
        textSize: CGFloat = 14
        ) {
        self.menuName = menuName
        self.id = id
        self.price = price
        self.lastPrice = lastPrice
        self.size = size
        self.color = color
        self.textSize = textSize
        self.selectedID = selectedID
        self.idCallback = idCallback
        self.priceCallback = priceCallback
    }

    var body: some View {
        Button(action:{
            self.idCallback(self.id)
            self.priceCallback(self.price , self.lastPrice)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selectedID == self.id ? "circle.circle.fill" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    .modifier(ColorInvert())
                Text("\(menuName)")
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

//struct SelectMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectMenuView()
//    }
//}
