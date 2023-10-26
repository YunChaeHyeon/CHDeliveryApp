//
//  StoreRegisterViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/12.
//

import Foundation
import SwiftUI

struct RequiredList: Identifiable {
    var id = UUID()
    var title : String = ""
    var priceString : String = "0"
    var price : Int = 0
    
//    init(id: UUID ){
//        self.price = Int(priceString)!
//    }
    mutating func setPrice(){
        price = Int(priceString)!
    }
    
}

struct Required : Identifiable {
    var id = UUID()
    var title : String = ""
    var RequiredLists : [RequiredList] = []
}

struct OptionList : Identifiable {
    var id = UUID()
    var title : String = ""
    var priceString : String = "0"
    var price : Int = 0
    
    //var OptionsLists : [OptionList]?
    
    init(id : UUID , title : String) {
        self.price = Int(priceString)!
        self.title = title
    }
    
    mutating func setPrice(){
        price = Int(priceString)!
    }
}

struct Option : Identifiable {
    var id = UUID()
    var title : String = ""
    var OptionsLists : [OptionList] = []
}

class StoreRegisterViewModel: ObservableObject {
    
    @Published var Requireds : [Required] = []
    @Published var Options : [Option] = []
    
    @Published var stores: [Store] = Array(Store.findAll())
    
    @objc dynamic var storeImage: NSData? = nil
    
    @Published var storeName : String = ""
    @Published var minDelivery : Int = 0
    @Published var payMethod : String = "바로결제"
    @Published var minTime : Int = 0
    @Published var tip : Int = 0
    
    // Menu
    var menus : [Menu] = Array<Menu>()
    @objc dynamic var menuImage: NSData? = nil
    @Published var menuName : String = ""
    
    //MenuRequired
    var menuRequireds : [MenuRequired] = Array<MenuRequired>()
    @Published var menuRequirName = [String]()
    
        //MenuRequiredList
    var menuRequiredList : [MenuRequiredList] = Array<MenuRequiredList>()
    @Published var menuRequirListName = [""]
    @Published var menuRequirListPrice =  [Int]()
    
    //MenuOption
    var menuOptions : [MenuOptions] = Array<MenuOptions>()
    @Published var menuOptionName = [String]()
    
        //MenuOptionList
    var menuOptionList : [MenuOptionList] = Array<MenuOptionList>()
    @Published var menuOptionListName = [String]()
    @Published var menuOptionListPrice =  [Int]()
    
    //=============View Data 관리=======================
    @Published var MenuRequs = [String]()
    @Published var MenuOptions = [String]()
    
    func removeRequName(){
        self.menuRequirName.removeAll()
    }
    
    func addMenuRequireds(index : Int) {
        let menuRequ = MenuRequired()
        
        //menuRequ.menuRequitedTilte = menuRequirName[index]
    }
    
    func addMenu() {
        
        let menu = Menu()
        //menu.menuImage = menuImage
        menu.menuName = menuName
        self.menus.append(menu)
    }
    
    func add()
    {
        //guard !storeName.isEmpty else { return }
        //guard !payMethod.isEmpty else { return }
        
        let store = Store()
        store.storeMainImage = storeImage
        store.storeName = storeName
        store.minDelivery = minDelivery
        store.payMethod = payMethod
        store.minTime = minTime
        store.tip = tip
        store.menus.append(objectsIn: menus)
        self.stores.append(store)
        Store.addStore(store)
        
    }
    
    func refreshStore() -> Void {
        self.stores = Array(Store.findAll())
    }
    
    func del(old : Store){
        Store.delStore(old)
    }
    
    func editMemo(old: Store) -> Void {
        guard !storeName.isEmpty else { return }
        guard !payMethod.isEmpty else { return }
        
        Store.editStore(store: old, storeName: storeName, minDelivery: minDelivery, payMethod: payMethod, minTime: minTime, tip: tip)
    }
    
}
