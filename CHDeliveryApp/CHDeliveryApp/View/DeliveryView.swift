//
//  DeliveryView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/04.
//

import SwiftUI

struct DeliveryView: View {
    @ObservedObject var homeState : HomeState
    @Environment(\.dismiss) private var dismiss
    @State private var tag:Int? = nil
    
    var body: some View {
            ScrollView{
                //Top
                VStack{
                    SliderView()
                        //.padding(.bottom, 20)
                    
                    DeliveryGuideView()
                    
                    DeliveryGridView()
                    
                }.background(Color.white)
                    .padding(20)

                VStack(){
                    
                    CustomerSelectionView()
                    
                    RandomShopView()
                    
                    
                    
                }.background(Color.white)
                
                Spacer(minLength: 100)
            }
            .onAppear(perform: {
                    homeState.isHiddenTap()
            })
            .background(
                VStack(spacing: .zero) {
                    Color.white
                        .frame(height : 120)
                        Color(hex: 0xEFEFEF)
                
            })
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
                    NavigationLink(destination: CartView(homeState: homeState,CartVM: CartViewModel()) , tag: 1, selection: self.$tag , label: {
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



struct DeliveryGuideView : View {
    
    var body: some View {
        VStack {

            ScrollView(.horizontal , showsIndicators: false) {
                HStack {
                    //카페인 충전
                    Button(action:{} , label: {
                        Text("카페인 충전")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))
                    //재주문 많아요
                    Button(action:{} , label: {
                        Text("재주문 많아요")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))
                    
                    //주문 전 쿠폰 받기
                    Button(action:{} , label: {
                        Text("주문 전 쿠폰 받기")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))
                    
                    //배달팁 낮은 가게
                    Button(action:{} , label: {
                        Text("배달팁 낮은 가게")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))
                    
                    //최다 찜 가게
                    Button(action:{} , label: {
                        Text("최다 찜 가게")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))
                    
                    //집밥이 그리워
                    Button(action:{} , label: {
                        Text("집밥이 그리워")
                            
                    }).padding(10)
                        .buttonStyle( HomeButtonStyle(width: 120, height: 90, fontsize: 15, backColor: Color.random2))

                }.padding(.horizontal, 10)
                    .foregroundColor(Color.white)
            }
            
        }.padding(.vertical, 10)
        .background(Color.white)
    }
}

struct Category {
    let foodName = ["족발 보쌈" , "찜 탕 찌개" , "일식", "피자","고기","야식","양식","치킨","중식","백반","도시락","분식","패스트푸드","아시안"]
}

struct DeliveryGridView : View {
    //@ObservedObject var homeState : HomeState
    
    let image = ["porkfeet","soup","sushi","pizza","meat","moon","pasta","chicken","Jajangmyeon","rice","lunchbox","tteokbokki","hamburger","ricenoodles"]
    
    var Foods : Category = Category()
    
    let columns = [
        GridItem(.fixed(75)),
        GridItem(.fixed(75)),
        GridItem(.fixed(75)),
        GridItem(.fixed(75)),
        GridItem(.fixed(75)),
    ]
    
    @State private var tag:Int? = nil
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            
                        ForEach(0..<14) { ix in
                            NavigationLink(destination: SelectShopView(tabIndex: ix) , tag: ix, selection: self.$tag , label: {
                                Button(action: {
                                    self.tag = ix
                                } , label: {
                                    VStack{
                                        Image("category/\(image[ix])")
                                            .resizable().frame(width: 50, height: 50)
                                        Text("\(Foods.foodName[ix])").foregroundColor(Color.black)
                                    }
                                }).buttonStyle(HomeButtonStyle(width: 80,height: 80 ,fontsize: 15))
                                  
                            })

                                
                            
                         //Button(action: {self.tag = 1}, label: {Text("1")})
                                    //Button(action: {self.tag = 1}, label: {Text("\(ix)")})

                          }
                        
                    }//LazyVGrid
        
    }
}

struct CustomerSelectionView : View {
    var body : some View {
        VStack{
            HStack(spacing: 10){
                Spacer()
                Button(action: {} , label: {
                    HStack{
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable().frame(width: 15 , height: 15).foregroundColor(Color.black)
                        Text("기본순").foregroundColor(Color.black)
                        
                    }   .frame(width: 100 , height:30)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(hex: 0xD6D6D6), lineWidth: 4)
                        )
                        .cornerRadius(30)
                })
                ScrollView(.horizontal , showsIndicators: false){
                    HStack{
                        //초기화
                        Button(action: {} , label: {
                            Text("초기화").foregroundColor(Color.black)
                                .frame(width: 100 , height:35)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(50)
                        })
                        //배달팁
                        Button(action: {} , label: {
                            Text("배달팁").foregroundColor(Color.black)
                                .frame(width: 100 , height:35)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(50)
                        })
                        //최소주문금액
                        Button(action: {} , label: {
                            Text("최소주문금액").foregroundColor(Color.black)
                                .frame(width: 100 , height:35)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(50)
                        })
                        //1인분
                        Button(action: {} , label: {
                            Text("1인분").foregroundColor(Color.black)
                                .frame(width: 100 , height:35)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(50)
                        })
                        //기타
                        Button(action: {} , label: {
                            Text("기타").foregroundColor(Color.black)
                                .frame(width: 100 , height:35)
                                .background(Color(hex: 0xEFEFEF))
                                .cornerRadius(50)
                        })

                    }
                }
            }

        }.padding(10)
    }
}

struct RandomShopView : View {
    
    var body: some View {
        VStack {
            ForEach(0..<10){
                i in Button(action: {} , label: {
                    VStack{
                        //이미지 스택
                        HStack{
                        //메인 이미지
                            Image("FoodShop/foodshop0").resizable()
                                .frame(width: .infinity, height: 100, alignment: .topLeading)
                        //서브 이미지
                            VStack{
                                //1
                                Image("FoodShop/foodshop1").resizable()
                                    .frame(width: 100, height: 50, alignment: .topLeading)
                                //2
                                Image("FoodShop/foodshop2").resizable()
                                    .frame(width: 100, height: 50, alignment: .topLeading)
                            }
                        }
                        
                        VStack{
                            HStack{
                                Text("육회왕자 연어공주 대전 괴정점")
                                Image(systemName: "star.fill").foregroundColor(Color.yellow)
                                Text("5.0")
                            }
                            
                            HStack{
                                Text("배달 47~62분")
                                Text("배달팁 400원~2400원")
                            }
                            
                            HStack{
                                Text("최소주문 9,900원")
                                Text("포장가능")
                                Text("예약가능")
                            }
                        }.foregroundColor(Color.black)
                            .padding(10)

                        
                        
                    }

                })
                    .frame(width: 380, height: 200)
                    .cornerRadius(30)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 2, x: 1, y: 2)
                            .opacity(0.3)
                    )
                    .padding(10)

            }
        }
    }
}


//struct Delivery_Previews: PreviewProvider {
//    static var previews: some View {
//        DeliveryView()
//    }
//}

