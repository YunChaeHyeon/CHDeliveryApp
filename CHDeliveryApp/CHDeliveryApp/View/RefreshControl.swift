//
//  RefreshControl.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/08/04.
//

import SwiftUI

let image = UIImage(named: "food/food1")

struct RefreshControl: View {
    var coordinateSpace: CoordinateSpace
    var onRefresh: ()->Void
    @State var refresh: Bool = false
    
    public let imageTimer = Timer.publish(every: 1, on: .main , in: .common).autoconnect()

                 
    var body: some View {
        var index = 0
        GeometryReader { geo in
            if (geo.frame(in: coordinateSpace).midY > 50) {
                Spacer()
                    .onAppear {
                        if refresh == false {
                            onRefresh() ///call refresh once if pulled more than 50px
                        }
                        refresh = true
                    }
            } else if (geo.frame(in: coordinateSpace).maxY < 1) {
                Spacer()
                    .onAppear {
                        refresh = false
                        ///reset  refresh if view shrink back
                    }
            }
            ZStack(alignment: .center) {
                if refresh { ///show loading if refresh called
                    //ProgressView()
                    let randonInt = Int.random(in: 1...13)
                    HStack{
                    
                        Image("food/food"+String(randonInt)).resizable().frame(width:50 , height: 40, alignment: .center)

                        Text("땡겨요")
                            .frame(height:120, alignment: .center)
                            .font(.system(size: 30, weight: .bold))
                    }
                } else { ///mimic static progress bar with filled bar to the drag percentage
                    ForEach(0..<8) { tick in
                          VStack {
                              Rectangle()
                                .fill(Color(UIColor.tertiaryLabel))
                                .opacity((Int((geo.frame(in: coordinateSpace).midY)/7) < tick) ? 0 : 1)
                                  .frame(width: 3, height: 7)
                                .cornerRadius(3)
                              //Spacer()
                      }.rotationEffect(Angle.degrees(Double(tick)/(8) * 360))
                   }.frame(width: 20, height: 20, alignment: .center)
                }
            }.frame(width: geo.size.width)
        }.padding(.top, 7)
    }
}

