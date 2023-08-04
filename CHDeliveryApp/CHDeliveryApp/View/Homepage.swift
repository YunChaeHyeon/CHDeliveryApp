//
//  Homepage.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/02.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            TopView()
            //HomeMiddleView()
    }
}

//IOS16이하 버전에서 쓰는 네비게이션 BackGround 색상 지정
struct NavigationBarColorModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    public init(@ViewBuilder background: @escaping () -> Background) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance

        self.background = background
    }

    func body(content: Content) -> some View {
        // Color(UIColor.secondarySystemBackground)
        ZStack {
            content
            VStack {
                background()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 0, alignment: .center)

                Spacer() // to move the navigation bar to top
            }
        }
    }
}

public extension View {
    func navigationBarBackground<Background: View>(@ViewBuilder _ background: @escaping () -> Background) -> some View {
        modifier(NavigationBarColorModifier(background: background))
    }
}

struct TopView: View {
    var body: some View{
        NavigationView {

            MiddleView()
            
            .toolbar{
                // 1
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Button(action: {} ) {
                            Image(systemName: "bell")
                                .foregroundColor(Color.white)
                        }
                        Button(action: {} ) {
                            Image(systemName: "cart")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                // 2
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {} ,
                           label: {
                        HStack{
                            Image(systemName: "house")
                            Text("우리집")
                        }.foregroundColor(Color.white)
                            .font(.system(size:20 , weight: .bold))
                        
                    })
                }

            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color.white.edgesIgnoringSafeArea(.all)
            )
            .navigationBarBackground({
                Color.mint
            })

  }
 }
}



struct MiddleView: View {
    @State var emailAddress: String = ""
    var body: some View{
        ScrollView{

            
            ScrollView{

                RefreshControl(coordinateSpace: .named("RefreshControl")) {
                    //refresh view here
                }
                    Spacer().frame(height:80)
                    ChangeSelectView()
                    
                    TagView()
                        .padding(.top, 20)
                    
                    
                    MainOptionView()
                        .padding(20)
                    
                    SliderView()
                        .padding(.bottom, 20)
                    
                    TodayDiscountView()
                    
                    Spacer(minLength: 100)
                
            }.background(
                VStack(spacing: .zero) {
                        Color.mint
                        .frame(height : 120)
                        Color(hex: 0xEFEFEF)
                
            })
            //.background(Color(hex: 0xEFEFEF))
            
            
        }.background(VStack(spacing: .zero) { Color.mint; Color(hex: 0xEFEFEF) })
            .ignoresSafeArea()
        //.background(Color(hex: 0xEFEFEF))
        
    }
  }

struct ChangeSelectView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: {}, label: {
                HStack {
                        Spacer(minLength: 20)
                    
                    HStack (alignment: .center,
                                spacing: 0) {

                            Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .foregroundColor(.black)
                                        
                                        .frame(minWidth: 0, maxWidth: 30)
                                        .frame(minHeight: 0, maxHeight:33)
                                    
                            Text("치킨 나와라 뚝딱 !!  ")
                            .foregroundColor(Color.gray)
                        Spacer()
                        }  // HSTack
                                .frame(width: 350)
                            .padding([.top,.bottom], 2)
                            .padding(.leading, 5)
                            .background(Color.white, alignment: .center)
                        Spacer(minLength: 0)
                } //HStack
            })
        }.frame(height: 70)
        .background(Color.mint)
            .cornerRadius(30,corners: .bottomLeft)
            .cornerRadius(30, corners: .bottomRight)
    }
}

struct TagView : View {
    var body : some View {
        ScrollView(.horizontal , showsIndicators: false){
            HStack {
                ForEach(0..<10) {
                    Text("숫자 \($0)")
                        .frame(width: 150)
                        .foregroundColor(.black)
                        .font(.system(size: 30 , weight: .bold))
                        .background(Color.white)
                        .cornerRadius(20)
                }
            }.padding(.horizontal, 25)
        }.frame(height: .infinity)
    }
}

struct HomeButtonStyle: ButtonStyle {
    var width: CGFloat
    var height: CGFloat
    var fontsize : CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: fontsize ,weight: .bold))
            .frame(width: width, height: height)
            .background(Color.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.0 : 1.05)
    }
}

struct MainOptionView : View {
    var body: some View {
        
        VStack(spacing: 20){
            //알뜰 한집 배달 / 배달
            HStack(spacing: 20){
                Button(action: {}, label: {
                    Text("알뜰 한집 배달")
                })
                    .buttonStyle(HomeButtonStyle(width: 170,height: 170 ,fontsize: 23))
                
                Button(action: {}, label: {
                    Text("배달")
                }).buttonStyle(HomeButtonStyle(width: 170,height: 170 ,fontsize: 23))
            }
            
            //포장
            Button(action: {}, label: {
                Text("포장")
            }).buttonStyle(HomeButtonStyle(width: 350,height: 70 ,fontsize: 23))
            
            //B마트 / 뷰티관
            HStack(spacing: 20){
                Button(action: {}, label: {
                    Text("B마트")
                }).buttonStyle(HomeButtonStyle(width: 170,height: 120 ,fontsize: 23))
                Button(action: {}, label: {
                    Text("뷰티관")
                }).buttonStyle(HomeButtonStyle(width: 170,height: 120 ,fontsize: 23))
            }
            
            //배민 스토어
            Button(action: {}, label: {
                Text("배민 스토어")
            }).buttonStyle(HomeButtonStyle(width: 350,height: 70 ,fontsize: 23))
            
            //쇼핑라이브 / 전국별미 / 선물하기 / 웹툰
            HStack(spacing: 20){
                Button(action: {}, label: {
                    Text("쇼핑라이브")
                }).buttonStyle(HomeButtonStyle(width: 75,height: 100 ,fontsize: 13))
                
                Button(action: {}, label: {
                    Text("전국별미")
                }).buttonStyle(HomeButtonStyle(width: 75,height: 100 ,fontsize: 13))
                
                Button(action: {}, label: {
                    Text("선물하기")
                }).buttonStyle(HomeButtonStyle(width: 75,height: 100 ,fontsize: 13))
                
                Button(action: {}, label: {
                    Text("웹툰")
                }).buttonStyle(HomeButtonStyle(width: 75,height: 100 ,fontsize: 13))
                
            }
        }
        
    }
}

struct SliderView : View {
    let image = ["test1","test2","test3","test4"]
    public let timer = Timer.publish(every: 3, on: .main , in: .common).autoconnect()
    @State private var selection = 0
    
    var body: some View {

        VStack {
            TabView(selection : $selection) {
                ForEach(0..<4){
                    i in Image("\(image[i])").resizable()
                }
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onReceive(timer, perform: {_ in
                    withAnimation{
                        selection = selection < 3 ? selection + 1 : 0
                    }
                })
        }.frame(height: 150)
    }
    
}

struct TodayDiscountView : View {
    
    let image = ["test1","test2","test3","test4"]
    
    var body: some View {
        VStack {
            HStack{
                //Spacer()
                Text("오늘의 할인")

                    .padding(0)
                Spacer()
                Button(action: {} , label: {
                    HStack{
                        Text("전체보기")
                        Image(systemName: "chevron.right")
                    }.padding(0)
                    
                })
            }.padding(.horizontal)
            
            ScrollView(.horizontal , showsIndicators: false) {
                HStack {
                    
                    ForEach(0..<4){
                        i in Button(action:{} , label: {
                            Text("5천원 할인")
                                //.cornerRadius(10)
                                .frame(width: 270 , height: 130)
                                .background(Color.random)
                                .cornerRadius(10)
                           // Image("\(image[i])").resizable()


                        }).padding(10)
                    }
                }.padding(.horizontal, 10)
            }
            
        }.padding(.vertical, 10)
        .background(Color.white)
    }
}

    
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
    

