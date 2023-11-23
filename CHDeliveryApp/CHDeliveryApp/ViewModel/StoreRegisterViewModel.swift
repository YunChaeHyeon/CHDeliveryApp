//
//  StoreRegisterViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/12.
//

import Foundation
import SwiftUI

class StoreRegisterViewModel: ObservableObject {
    
    @Published var stores: [Store] = Array(Store.findAll())
    
    @objc dynamic var storeImage: NSData? = nil
    
    @Published var storeName : String = ""
    @Published var storeCategory : String = "족발 보쌈"
    @Published var minDelivery : Int = 0
    @Published var payMethod : String = "바로결제"
    @Published var minTime : Int = 0
    @Published var tip : Int = 0
    
    // Menu
    var menus : [Menu] = Array<Menu>()
    @objc dynamic var menuImage: NSData? = nil
    @Published var menuName : String = ""
    @Published var menuDefaultPrice : Int = 0 
    
    //MenuRequired
    @Published var menuRequireds : [MenuRequired] = Array<MenuRequired>()
    
        //MenuRequiredList
    @Published var menuRequiredList : [MenuRequiredList] = Array<MenuRequiredList>()
    
    //MenuOption
    @Published var menuOptions : [MenuOption] = Array<MenuOption>()
    
        //MenuOptionList
    @Published var menuOptionList : [MenuOptionList] = Array<MenuOptionList>()
    
    
    func getMenuImage(index : Int) -> Image {
        var image = Image("")
        if(menus[index].menuImage != nil){
            let menuImage = UIImage(data: menus[index].menuImage! as Data)
            image = Image(uiImage: menuImage!)
        }
        return image
    }
    
    func getMenuImage(store : Store , index : Int) -> Image {
        var image = Image("")
        if(store.menus[index].menuImage != nil){
            let menuImage = UIImage(data: store.menus[index].menuImage! as Data)
            image = Image(uiImage: menuImage!)
        }
        return image
    }
    
    
    func getStoreImage(store: Store) -> Image{
        var image = Image("")
        if(store.storeMainImage != nil) {
            let storeImage = UIImage(data: store.storeMainImage! as Data)
            image = Image(uiImage: storeImage!)
        }
        return image
    }
    
    //메뉴 등록
    func addMenu() {
        let menu = Menu()
        
        menu.menuRequired.append(objectsIn: menuRequireds)
        menu.menuOptions.append(objectsIn: menuOptions)
        menu.menuImage = menuImage
        menu.menuName = menuName
        menu.menuDefaultPrice = menuDefaultPrice
        
        self.menus.append(menu)
    }
    
    //store 등록
    func addStore()
    {
        //guard !storeName.isEmpty else { return }
        //guard !payMethod.isEmpty else { return }
        
        let store = Store()
        store.storeMainImage = storeImage
        store.storeName = storeName
        store.storeCategory = storeCategory
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
    
    func delStore(old : Store){
        Store.delStore(old)
    }
    
    func editStore(old: Store) -> Void {
        guard !storeName.isEmpty else { return }
        guard !payMethod.isEmpty else { return }
        
        Store.editStore(store: old, storeName: storeName, minDelivery: minDelivery, payMethod: payMethod, minTime: minTime, tip: tip)
    }
    
}
