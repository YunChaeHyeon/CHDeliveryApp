import SwiftUI

//struct MenuItem: Identifiable {
//    var id = UUID()
//    var name: String = ""
//    var image: String  = ""
//    var subMenuItems: [MenuItem]?
//}
//
//let espressoMachineMenuItems = [ MenuItem(name: "Leva", image: "leva-x", subMenuItems: [ MenuItem(name: "Leva X", image: "leva-x"), MenuItem(name: "Leva S", image: "leva-s") ]),
//                                 MenuItem(name: "Strada", image: "strada-ep", subMenuItems: [ MenuItem(name: "Strada EP", image: "strada-ep"), MenuItem(name: "Strada AV", image: "strada-av"), MenuItem(name: "Strada MP", image: "strada-mp"), MenuItem(name: "Strada EE", image: "strada-ee") ]),
//                                 MenuItem(name: "KB90", image: "kb90"),
//                                 MenuItem(name: "Linea", image: "linea-pb-x", subMenuItems: [ MenuItem(name: "Linea PB X", image: "linea-pb-x"), MenuItem(name: "Linea PB", image: "linea-pb"), MenuItem(name: "Linea Classic", image: "linea-classic") ]),
//                                 MenuItem(name: "GB5", image: "gb5"),
//                                 MenuItem(name: "Home", image: "gs3", subMenuItems: [ MenuItem(name: "GS3", image: "gs3"), MenuItem(name: "Linea Mini", image: "linea-mini") ])
//                                ]
//
//let sampleMenuItems = [ MenuItem(name: "Espresso Machines", image: "linea-mini", subMenuItems: espressoMachineMenuItems),
//                        MenuItem(name: "Grinders", image: "swift-mini", subMenuItems: grinderMenuItems),
//                        MenuItem(name: "Other Equipment", image: "espresso-ep", subMenuItems: otherMenuItems)
//                    ]
//
//let grinderMenuItems = [ MenuItem(name: "Swift", image: "swift"),
//                         MenuItem(name: "Vulcano", image: "vulcano"),
//                         MenuItem(name: "Swift Mini", image: "swift-mini"),
//                         MenuItem(name: "Lux D", image: "lux-d")
//                        ]
//
//// Sub-menu items for other equipment
//let otherMenuItems = [ MenuItem(name: "Espresso AV", image: "espresso-av"),
//                         MenuItem(name: "Espresso EP", image: "espresso-ep"),
//                         MenuItem(name: "Pour Over", image: "pourover"),
//                         MenuItem(name: "Steam", image: "steam")
//                        ]
//
//struct DemoView: View {
//    var body: some View {
//        List {
//            ForEach(sampleMenuItems) { menuItem in
//
//                Section(header:
//                    HStack {
//
//                        Text(menuItem.name)
//                            .font(.title3)
//                            .fontWeight(.heavy)
//
//                        Image(menuItem.image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//
//                    }
//                    .padding(.vertical)
//
//                ) {
//                    OutlineGroup(menuItem.subMenuItems ?? [MenuItem](), children: \.subMenuItems) {  item in
//                        HStack {
//                            Image(item.image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 50, height: 50)
//
//                            Text(item.name)
//                                .font(.system(.title3, design: .rounded))
//                                .bold()
//                        }
//                    }
//                }
//            }
//        }.listStyle(.plain)
//    }
//}

struct TestView : View {
    var body: some View {
        Text("testView")
    }
}
struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
           // .environment(\.colorScheme, .dark)
    }
}
