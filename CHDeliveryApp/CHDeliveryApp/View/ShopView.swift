//
//  ShopView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/04.
//

import SwiftUI
import RealmSwift

struct ShopView: View {
    var storeData : Store
    @ObservedObject var homeState : HomeState
    @ObservedObject var storeRegiVM : StoreViewModel = StoreViewModel()
    @ObservedObject var cartVM = CartViewModel()
    @ObservedObject var likeVM = LikeViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var tag:Int? = nil
    
    @State var like : Bool = false
    @State var scale : CGFloat = 1
    
    init(_ storeData : Store , _ homeState : HomeState){
        self.storeData = storeData
        self.homeState = homeState
    }
    
    var body: some View {
        
        ScrollView {
            VStack{
                if(storeData.storeMainImage != nil){
                    storeRegiVM.getStoreImage(store: storeData)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 200)
                        .clipped()
                        .padding(.bottom , 20)
                }
                //Title
                Text("\(storeData.storeName)")
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
                    
                    
                    Image(systemName: like ? "heart.fill" : "heart").font(.system(size: 20))
                        .foregroundColor(like  ? .red : .gray)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: 0.2))
                        .onAppear{
                            like = storeData.like
                        }
                        .onTapGesture {
                            like.toggle()
                            scale = like  ? 1.2 : 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                scale = 1
                            }

                            storeRegiVM.editStoreLike(old: storeData, like: like)
                            
                            if(like){
                                likeVM.storeName = storeData.storeName
                                likeVM.addLike(add: storeData)
                            }else{
                                likeVM.delLike(old: storeData)
                            }
                        }
                    
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
                deliveryOrpackagingTopTabBar(storeData : storeData ,storeRegiVM: StoreViewModel() , tabIndex: 0, isStoreView: true , isEdit : false)
                //최소주문금액 /이용방법 /픽업 시간/ 위치 안내 (지도) / 결제방법
            } //VStack
            .background(Color.white)
            
            VStack{
                //3 탭바 : 메뉴 / 정보 / 리뷰
                MenuOrInformaOrReview(storeData : storeData ,storeRegiVM: StoreViewModel() ,tabIndex: 0 , isStoreRegister: false , isEdit: false)
            }.background(Color.white)
        }
        .onAppear{
            homeState.isHiddenTap()
        }
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
                                        homeState.isVisibilityTap()
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
                    NavigationLink(destination: CartView(homeState:  HomeState()) , tag: 1, selection: self.$tag , label: {
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


struct MenuOrInformaOrReview : View {
    var storeData : Store
    @ObservedObject var cartVM = CartViewModel()
    @ObservedObject var storeRegiVM : StoreViewModel
    @State var tabIndex: Int
    var isStoreRegister : Bool
    var isEdit : Bool
    
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
            if(!isStoreRegister){
                TabBarButton(text: "리뷰", isSelected: .constant(tabIndex == 2)).onTapGesture {
                    onButtonTapped(index: 2)
                }
                Spacer()
            }

        }
    .border(width: 1, edges: [.bottom], color: .black)
        
        if(!isStoreRegister && !isEdit){
                //가게 찾아 볼 때
                if(tabIndex == 0){
                    VStack{
                        Text("대표 메뉴")
                        ForEach( Array(storeData.menus.enumerated()) , id : \.offset) {
                            index, menu in NavigationLink(destination: SelectMenuView(storeData : storeData,cartVM : cartVM , MenuItem : menu) , tag: index , selection: self.$tag , label: {
                                Button(action: {
                                    self.tag = index
                                } , label: {
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("\(menu.menuName)").font(.system(size: 20 , weight: .bold))
                                           
                                        Text("\(menu.menuDefaultPrice)원")
                                            .font(.system(size: 16 , weight: .bold))
                                    }.padding(.leading , 30)
                                     .foregroundColor(Color.black)
                                    Spacer()
                                    storeRegiVM.getMenuImage(store: storeData, index: index)
                                        .resizable()
                                        .cornerRadius(20)
                                        .frame(width: 120, height: 120)
                                        .padding(.trailing , 30)
                                }
                                    
                            })
                            })
                            Divider().background(Color.gray)
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
                        NavigationLink(destination: RegisterMenuView(storeRegiVM: storeRegiVM, storeData: storeData, isMenuEdit: true , isEdit : isEdit,isRegister: isStoreRegister, menuIndex: index ), tag: index, selection: self.$tag, label: {
                            AddMenuView(storeRegiVM : storeRegiVM, Index: index).foregroundColor(Color.black)
                            Divider().background(Color.blue)

                        }
                            
                        )

                    }
                    
                    NavigationLink(destination: RegisterMenuView(storeRegiVM: storeRegiVM, storeData: storeData, isMenuEdit: false , isEdit: false ,isRegister: isStoreRegister, menuIndex: 0) , tag: 100, selection: self.$tag , label: {
                        Button(action: {
                            self.tag = 100
                        }, label: {
                            VStack{

                                Text("가게 메뉴 등록").foregroundColor(Color.black)
                                Image(systemName: "plus.app.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                            }

                        }).padding(20)
                    })
                }.onAppear{
                    print("isEdit? : \(isEdit)")
                    
                    if(isEdit){
                        storeRegiVM.menus = Array(storeData.menus)
                    }

                    
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
    @ObservedObject var storeRegiVM : StoreViewModel
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
    var storeData : Store
    @ObservedObject var storeRegiVM : StoreViewModel
    
    @State var isStoreView : Bool
    @State var textTilte : String
    var saveTextNumber : Int
    var isEdit : Bool
    
    var options : [String] = ["바로결제","만나서 결제","바로결제 , 만나서 결제"]
    var categorys : [String] = ["족발 보쌈" , "찜 탕 찌개" , "일식", "피자","고기","야식","양식","치킨","중식","백반","도시락","분식","패스트푸드","아시안"]
    
    var body: some View {

            switch(saveTextNumber) {
            case 1:
                if(isStoreView){
                    Text("\(storeData.minDelivery)")
                }else{
                    HStack{
                        TextField(textTilte , value: $storeRegiVM.minDelivery , format: .number)
                            .frame(width: 80)
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 16)
                            .background(borderStyleView())
                            .onAppear{
                                if(isEdit){
                                    storeRegiVM.minDelivery = storeData.minDelivery
                                }
                                
                            }

                    }

                }

            case 2:
                if(isStoreView){
                    Text("\(storeData.storeCategory)")
                }else{
                    HStack{
                        Picker("카테고리" , selection: $storeRegiVM.storeCategory){
                            ForEach(categorys , id: \.self){ category in
                                Text(category).foregroundColor(Color.green)
                                
                            }
                        }.padding(.leading , 10)
                            .accentColor(.green)
                            .onAppear{
                                if(isEdit){
                                    storeRegiVM.storeCategory = storeData.storeCategory
                                }
                            }
                            
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.green, lineWidth: 2)
                    )
                }

            case 3:
                if(isStoreView){
                    Text("\(storeData.payMethod)")
                }else{
                    HStack{
                        Picker("결제 방법" , selection: $storeRegiVM.payMethod){
                            ForEach(options , id: \.self){ option in
                                Text(option).foregroundColor(Color.mint)
                                
                            }
                        }.padding(.leading , 10)
                            .accentColor(.mint)
                            .onAppear{
                                if(isEdit){
                                    storeRegiVM.payMethod = storeData.payMethod
                                }
                            }
                            
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.mint, lineWidth: 2)
                    )
                }


            case 4:
                if(isStoreView){
                    Text("\(storeData.minTime)")
                }else{
                    TextField(textTilte , value : $storeRegiVM.minTime , format: .number)
                        .frame(width: 80)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .onAppear{
                            if(isEdit){
                                storeRegiVM.minTime = storeData.minTime
                            }
                        }
                }

            case 5:
                if(isStoreView){
                    Text("\(storeData.tip)")
                }else{
                    TextField(textTilte , value: $storeRegiVM.tip , format: .number )
                        .frame(width: 80)
                        .keyboardType(.numberPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 16)
                        .background(borderStyleView())
                        .onAppear{
                            if(isEdit){
                                storeRegiVM.tip = storeData.tip
                            }
                        }
                }

                
            default:
                Text("No Number")
            }

    }
}

struct deliveryOrpackagingTopTabBar: View {
    var storeData : Store
    @ObservedObject var storeRegiVM : StoreViewModel
    @State var tabIndex: Int
    @State var isStoreView : Bool
    var isEdit : Bool
    
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
                    TextOrTextField(storeData : storeData ,storeRegiVM: storeRegiVM, isStoreView: isStoreView, textTilte: "", saveTextNumber: 2 ,isEdit: isEdit)
                }
                HStack{
                    Text("결제 방법").padding(.trailing, 55)
                    TextOrTextField(storeData : storeData , storeRegiVM: storeRegiVM, isStoreView: isStoreView, textTilte: "", saveTextNumber: 3 , isEdit : isEdit)
                }
                HStack{
                    Text("최소 주문 금액").padding(.trailing, 20)
                    TextOrTextField(storeData : storeData , storeRegiVM: storeRegiVM, isStoreView: isStoreView, textTilte: "금액 입력", saveTextNumber: 1 , isEdit : isEdit)
                    Text("원")
                    Spacer()
                }
                HStack{
                    Text("배달 시간").padding(.trailing, 55)
                    TextOrTextField(storeData : storeData , storeRegiVM: storeRegiVM, isStoreView: isStoreView, textTilte: "시간 입력", saveTextNumber: 4, isEdit : isEdit)
                    Text("분 소요 예상")
                }

                HStack{
                    Text("배달팁").padding(.trailing, 75)
                    TextOrTextField(storeData : storeData , storeRegiVM: storeRegiVM, isStoreView: isStoreView, textTilte: "금액 입력", saveTextNumber: 5, isEdit: isEdit)
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

