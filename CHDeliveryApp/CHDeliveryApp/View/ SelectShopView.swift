//
//   SelectShopView.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/09.
//

import SwiftUI


struct SelectShopView: View {
    @Environment(\.dismiss) private var dismiss
    @State var tabIndex : Int
    
    var body: some View {
        VStack{
            VStack{
                
                CustomTopTabBar(tabIndex: $tabIndex)
                    .padding(.bottom, -7)
                
                CustomerSelectionView()
                
               
            }.background(Color.white)
            ScrollView{
                
                CategoryShopView(CategoryNum: tabIndex).background(Color.white)
                
                Spacer(minLength: 100)
            }.background(Color(hex: 0xEFEFEF))
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
                    }
        }.background(Color(hex: 0xEFEFEF))
    
    }
}

struct SecondView: View{
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.yellow)
            Text("SecondView")
        }
    }
}

struct CustomTopTabBar: View {
    
    var Foods : Category = Category()
    
    @Binding var tabIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20) {
                ForEach(0..<14){
                    i in TabBarButton(text: "\(Foods.foodName[i])", isSelected: .constant(tabIndex == i))
                        .onTapGesture { onButtonTapped(index: i) }
                }
                Spacer()
            }
        }

        .border(width: 1, edges: [.bottom], color: .black)
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct CategoryShopView : View {
    
    var Foods : Category = Category()
    var CategoryNum : Int
    var ShopImage = ["Shop0","Shop1","Shop2","Shop3","Shop4","Shop5","Shop6","Shop7","Shop8","Shop9","Shop10","Shop11","Shop12","Shop13"]
    
    var body: some View {
        VStack(spacing: 0){
        ForEach(0..<10) {
            i in Button(action: {} , label: {
                HStack(spacing: 0){
                        Image("Shop/\(ShopImage[CategoryNum])").resizable().frame(width: 100, height: 120 ,alignment: .leading)
                        
                        Spacer()
                        VStack(spacing: 0){
                            //Text("")
                            //Shop Tilte
                            Text("\(Foods.foodName[CategoryNum])").font(.system(size: 20 , weight: .bold))
                        }
                        Spacer()
                    }

            }).frame(width: .infinity, height: .infinity, alignment: .topLeading)
        }
      }
    }
}



struct SelectShopView_Previews: PreviewProvider {
    static var previews: some View {
        SelectShopView(tabIndex: 0)
    }
}

