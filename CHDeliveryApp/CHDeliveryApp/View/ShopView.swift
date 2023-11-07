//
//  ShopView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/04.
//

import SwiftUI

struct ShopView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tag:Int? = nil
    var body: some View {
        
        ScrollView {
            VStack{
                //Title
                Text("가게 이름")
                    .font(.system(size: 25 , weight: .bold))
                    .padding(.bottom, 5)
                //별점
                HStack{
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    Text("5.0")
                        .font(.system(size: 25))
                }.padding(.bottom ,5)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                
                //최근리뷰
                HStack {
                    Text("최근리뷰").foregroundColor(Color.gray)
                    Text("543").foregroundColor(Color.gray)
                }.padding(.bottom ,5)
                
                //전화 / 하트 / 공유
                HStack{
                    Spacer()
                    Image(systemName: "phone").font(.system(size: 20))
                    Text("전화")
                    
                    Spacer()
                    
                    Image(systemName: "heart").font(.system(size: 20))
                    Text("3,405")
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.up").font(.system(size: 20))
                    Text("공유")
                    Spacer()
                }.padding(.bottom ,5)
                
                //쿠폰
                Button(action: {} , label: {
                    HStack{
                        
                        Text("최대 2,000원 쿠폰 받기").foregroundColor(Color.orange)
                        Image(systemName: "arrow.down.to.line").font(.system(size: 20)).foregroundColor(Color.orange)
                        
                    }
                }) .buttonStyle(HomeButtonStyle(width: 320,height: 45 ,fontsize: 17, backColor: Color(hex: 0xEFEFEF)))
                    .padding(.bottom ,20)
                    .shadow(color: .gray, radius: 1, x: 0.3, y: 0.3)
                
                //2 탭바 : 배달주문 / 포장/방문 주문
                //배달주문 최소주문금액 , 결제 방법 , 배달 시간 , 배달팁
                //TestVMView(storeRegiVM: StoreRegisterViewModel())
                deliveryOrpackagingTopTabBar(storeRegiVM: StoreRegisterViewModel() , tabIndex: 0, isText: true)
                //최소주문금액 /이용방법 /픽업 시간/ 위치 안내 (지도) / 결제방법
            } //VStack
            .padding(10)
            .background(Color.white)
            
            VStack{
                //3 탭바 : 메뉴 / 정보 / 리뷰
                MenuOrInformaOrReview(storeRegiVM: StoreRegisterViewModel() ,tabIndex: 0 , isStoreRegister: false)
            }.background(Color.white)
        }
            //.background(Color(hex: 0xEFEFEF))//ScrollView
        .background(
            VStack(spacing: .zero) {
                Color.white
                    .frame(height : 100)
                    Color(hex: 0xEFEFEF)
        })
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
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
            .navigationBarBackground({
                Color.white
            })

    }

}


struct TestVMView : View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    var body: some View {
        Text("Hi")
    }
}

struct MenuOrInformaOrReview : View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    @State var tabIndex: Int
    var isStoreRegister : Bool
    
    @State private var tag:Int? = nil
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            TabBarButton(text: "메뉴", isSelected: .constant(tabIndex == 0)).onTapGesture {
                onButtonTapped(index: 0)
            }
            Spacer()
            TabBarButton(text: "정보", isSelected: .constant(tabIndex == 1)).onTapGesture {
                onButtonTapped(index: 1)
            }
            Spacer()
            if(isStoreRegister == false){
                TabBarButton(text: "리뷰", isSelected: .constant(tabIndex == 2)).onTapGesture {
                    onButtonTapped(index: 2)
                }
                Spacer()
            }

        }
    .border(width: 1, edges: [.bottom], color: .black)
        
        if(isStoreRegister == false){
                //가게 찾아 볼 때
                if(tabIndex == 0){
                    VStack{
                        Text("대표 메뉴")
                        ForEach(0..<14) {
                            i in NavigationLink(destination: SelectMenuView() , tag: i, selection: self.$tag , label: {
                                Button(action: {self.tag = i } , label: {
                                HStack{
                                    VStack{
                                        Text("New 메뉴이름").font(.system(size: 20 , weight: .bold))
                                            .foregroundColor(Color.black)
                                        Text("음식 설명").foregroundColor(Color.gray)
                                    }
                                    Image("food/food1")
                                }
                                    
                            })
                            })
                        }
                    }
                }else if(tabIndex == 1){
                    VStack{
                        Text("가게 정보")

                    }
                }else{
                    VStack{
                        Text("리뷰")

                    }
                }
        }else{
            //가게 정보 등록시
            if(tabIndex == 0){
                VStack{
                    ForEach(storeRegiVM.menus.indices , id:\.self){
                        index in
                        AddMenuView(storeRegiVM : storeRegiVM, Index: index)
                        Divider().background(Color.blue)
                    }
                    
                    NavigationLink(destination: RegisterMenuView(storeRegiVM) , tag: 0, selection: self.$tag , label: {
                        Button(action: {
                            self.tag = 0
                        }, label: {
                            VStack{

                                Text("가게 메뉴 등록").foregroundColor(Color.black)
                                Image(systemName: "plus.app.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                            }

                        }).padding(20)
                    })
                }

                
            }else{
                
                Button(action: {
                }, label: {
                    VStack{
                        Text("가게 정보 등록").foregroundColor(Color.black)
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color.black)
                            .font(.system(size: 50))
                    }

                }).padding(20)
                
            }
            
        }
    
 
        
  }
    
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct AddMenuView : View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    @State var Index : Int
    var body: some View {

        HStack{
            
            if(self.Index < self.storeRegiVM.menus.count){
            Spacer()
            VStack{
                
                    Text("\(storeRegiVM.menus[Index].menuName)").font(.system(size: 25 , weight: .bold))
                        .foregroundColor(Color.black)
                        .padding(.bottom , 5)
                    Text("\(storeRegiVM.menus[Index].menuDefaultPrice)원").font(.system(size: 20 , weight: .bold))
            }
                
            storeRegiVM.getMenuImage(index: Index)
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            }
            
            Button(action: {
                storeRegiVM.objectWillChange.send()
                storeRegiVM.menus.remove(at: Index)
            }, label: {Image(systemName: "trash.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20))
            }).padding(.trailing , 15)
        }
    }
}
    
struct TextOrTextField : View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    
    @State var isText : Bool
    @State var textTilte : String
    var saveTextNumber : Int
    
    var options : [String] = ["바로결제","만나서 결제","바로결제 , 만나서 결제"]
    var categorys : [String] = ["족발 보쌈" , "찜 탕 찌개" , "일식", "피자","고기","야식","양식","치킨","중식","백반","도시락","분식","패스트푸드","아시안"]
    
    var body: some View {
        if(isText){
            Text("불러오기")
        }else{
            switch(saveTextNumber) {
            case 1:
                TextField(textTilte , value: $storeRegiVM.minDelivery , format: .number)
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
            case 2:
                HStack{
                    Picker("카테고리" , selection: $storeRegiVM.storeCategory){
                        ForEach(categorys , id: \.self){ category in
                            Text(category).foregroundColor(Color.green)
                            
                        }
                    }.padding(.leading , 10)
                        .accentColor(.green)
                    Image(systemName: "chevron.right").foregroundColor(Color.green)
                        .padding(.trailing ,5)
                        
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.green, lineWidth: 2)
                )
            case 3:
                HStack{
                    Picker("결제 방법" , selection: $storeRegiVM.payMethod){
                        ForEach(options , id: \.self){ option in
                            Text(option).foregroundColor(Color.mint)
                            
                        }
                    }.padding(.leading , 10)
                        .accentColor(.mint)
                    Image(systemName: "chevron.right").foregroundColor(Color.mint)
                        .padding(.trailing ,5)
                        
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.mint, lineWidth: 2)
                )

            case 4:
                TextField(textTilte , value : $storeRegiVM.minTime , format: .number)
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
            case 5:
                TextField(textTilte , value: $storeRegiVM.tip , format: .number )
                    .frame(width: 80)
                    .textFieldStyle(PlainTextFieldStyle())
                    .fixedSize(horizontal: true, vertical: false)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 16)
                    .background(borderStyleView())
                
            default:
                Text("No Number")
            }

        }
        

    }
}

struct deliveryOrpackagingTopTabBar: View {
    @ObservedObject var storeRegiVM : StoreRegisterViewModel
    @State var tabIndex: Int
    @State var isText : Bool
    
    var body: some View {
            HStack(spacing: 20) {
                Spacer()
                TabBarButton(text: "배달주문", isSelected: .constant(tabIndex == 0)).onTapGesture {
                    onButtonTapped(index: 0)
                }
                Spacer()
                TabBarButton(text: "포장/방문주문", isSelected: .constant(tabIndex == 1)).onTapGesture {
                    onButtonTapped(index: 1)
                }
                Spacer()
                
            }
        .border(width: 1, edges: [.bottom], color: .black)
        if(tabIndex == 0){
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Text("카테고리").padding(.trailing, 59)
                    TextOrTextField(storeRegiVM: storeRegiVM, isText: isText, textTilte: "", saveTextNumber: 2)
                }
                HStack{
                    Text("결제 방법").padding(.trailing, 55)
                    TextOrTextField(storeRegiVM: storeRegiVM, isText: isText, textTilte: "", saveTextNumber: 3)
                }
                HStack{
                    Text("최소 주문 금액").padding(.trailing, 20)
                    TextOrTextField(storeRegiVM: storeRegiVM, isText: isText, textTilte: "금액 입력", saveTextNumber: 1)
                    Text("원")
                    Spacer()
                }
                HStack{
                    Text("배달 시간").padding(.trailing, 55)
                    TextOrTextField(storeRegiVM: storeRegiVM, isText: isText, textTilte: "시간 입력", saveTextNumber: 4)
                    Text("분 소요 예상")
                }

                HStack{
                    Text("배달팁").padding(.trailing, 75)
                    TextOrTextField(storeRegiVM: storeRegiVM, isText: isText, textTilte: "금액 입력", saveTextNumber: 5)
                    Text("원")
                }
                
            }.padding(.leading ,15)
        }else{
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Text("최소 주문 금액").padding(.trailing, 20)
                    Text("없음")
                    Spacer()
                }
                HStack{
                    Text("이용 방법").padding(.trailing, 55)
                    Text("매장, 포장")
                }
                HStack{
                    Text("픽업 시간").padding(.trailing, 55)
                    Text("10~15분 소요 예상")
                }

                HStack{
                    Text("위치 안내").padding(.trailing, 55)
                    Text("위치기입")
                }
                
            }
        }
        
            
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
    
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
