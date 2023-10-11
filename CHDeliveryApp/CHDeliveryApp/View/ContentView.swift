//
//  ContentView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/02.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        BottomTapbarView()
    }
}

var tabs = ["select" , "favorite", "home", "order" , "mapage"]

class HomeState: ObservableObject {
    @Published var isTap : Bool = false
    
    func isHiddenTap() {
        if(isTap == false){
            print("숨긴다")
            isTap = true
        }

    }
    
    func isVisibilityTap(){
        //if(isTap == true){
            print("보인다")
            isTap = false
        //}

    }
}

struct BottomTapbarView: View {
    
    @State var tabSelection = "home"
    @ObservedObject var homeState = HomeState()
    @ObservedObject var userVM = UserViewModel()
    //let configuration = Realm.Configuration(schemaVersion: 3)
    
    init() {
        UITabBar.appearance().isHidden = true
        
        // Realm 가져오기
        //let realm = try! Realm(configuration: configuration)
        
        //데이터 Create
//        let user1 = User(id:1 , name: "CH")
//        try! realm.write {
//            realm.add(user1)
//        }
        
        //데이터 Delete
//        try! realm.write {
//            let data = realm.objects(User.self)
//            realm.delete(data)
//        }
        
        //데이터 Update
//        var users: Results<User>!
//        try! realm.write {
//            users[0].name = "YC"
//        }

        // Realm 파일 위치
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //데이터 프린트 (Read)
        //var users: Results<User>!
        //users = realm.objects(User.self)
        //print(users)
    }
    
    //Location For each Curve..
    @State var xAxis: CGFloat = 0
    @State var isTapHidden : Bool = false
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){

            TabView(selection:$tabSelection){

                
                Color.yellow
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("select")
                
                Color.purple
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("favorite")
                
                HomeView(homeState: homeState)
                    .tag("home")
                
                Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("order")
                
                MyPageView(homeState: homeState , userVM: userVM )
                    .tag("mapage")

                
            }
            .animation(.easeOut(duration: 0.2), value: tabSelection)
        .transition(.slide)
        
            
        //Custom Tab Bar ..
            
            HStack(spacing: 0){
                ForEach(tabs,id : \.self){image in
                    
                    GeometryReader { reader in
                        Button(action:{
                            withAnimation(.spring()){
                                tabSelection = image
                                if(image != "home"){
                                    xAxis = reader.frame(in: .global).minX
                                }else{
                                    xAxis = -100
                                }
                               
                                print(xAxis)
                            }
                        } , label: {
                            if(image == "home"){
                                Image(image)
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 50, height: 50)
                                   //.padding(tabSelection == image ? 15 : 0)
//                                   .background(Color.white.opacity(tabSelection == image ? 1: 0))
//                                   .clipShape(Circle())
                                   .offset(x: reader.frame(in: .global).minX - reader.frame(in: .global).midX ,y: tabSelection == image ? -10 : -10)
                            }else{
                                Image(image)
                                   .resizable()
                                   .renderingMode(.template)
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 25, height: 25)
                                   .foregroundColor(tabSelection == image ?  getColor(image: image) : Color.gray)
                                   .padding(tabSelection == image ? 15 : 0)
                                   .background(Color.white.opacity(tabSelection == image ? 1: 0))
                                   .clipShape(Circle())
                                   .offset(x: reader.frame(in: .global).minX - reader.frame(in: .global).midX ,y: tabSelection == image ? -45 : 0)
                            }


                        }).onAppear(perform: {
                            if image == tabs.first{
                                //처음 들어왔을 때 초기값.
                                xAxis = -100//reader.frame(in: .global).minX
                                
                            }
                        })
                    }.frame(width: 25, height: 25)
                    

                    
                    if image != tabs.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal,30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis))            .cornerRadius(12))
            .opacity(homeState.isTap ? 0:1)

            .padding(.horizontal)
            //Bottom Edge..
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)

        .ignoresSafeArea(.all, edges: .bottom)
        }
    }

    func getColor(image: String) ->Color {
        switch image {
        case "select":
            return Color.yellow
        case "favorite":
            return Color.purple
        case "order":
            return Color.blue
        case "mypage":
            return Color.mint
        default:
            return Color.black
        }
    }
}

struct CustomShape: Shape {
    var xAxis: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        return Path{
            path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50 , y: 0))
            
            let to1 = CGPoint(x: center, y:35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1 , control2: control2)
            path.addCurve(to: to2, control1: control3 , control2: control4)
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

