//
//  StoreModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/17.
//

import Foundation
import RealmSwift

class MenuOptionList : Object {
    @objc dynamic var menuOptionTitle : String = ""
    @objc dynamic var menuPrice : Int = 0
}
extension MenuOptionList {
    static func editMenuOptionList(_ menuOpList : MenuOptionList , menuOpName : String ){
        menuOpList.menuOptionTitle = menuOpName
    }
}

class MenuOption : Object {
    @objc dynamic var menuOptionsTilte : String = ""
    var menuOptionList = List<MenuOptionList>()
}
extension MenuOption {
    static func editMenuOption(_ menuOp : MenuOption , menuOpName : String ){
        menuOp.menuOptionsTilte = menuOpName
    }
}

class MenuRequiredList : Object {
    @objc dynamic var menuRequiredTitle : String = ""
    @objc dynamic var menuPrice : Int = 0
}

class MenuRequired : Object {
    @objc dynamic var menuRequitedTilte : String = ""
    var menuRequiredList = List<MenuRequiredList>()
}

class Menu : Object {
    @objc dynamic var menuImage: NSData? = nil
    @objc dynamic var menuName : String = ""
    @objc dynamic var menuDefaultPrice : Int = 0
    //아래가 추가의 필수는 아님
    //가격 선택 필수
    var menuRequired = List<MenuRequired>()
    //가격 선택 추가
    var menuOptions = List<MenuOption>()
}

extension Menu  {
    static var RequAddcount = 0
    static var RequListAddcount = 0
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Menu> {
        realm.objects(Menu.self)
    }
    
    // realm객체에 값을 추가
    static func addMenu(_ menu: Menu) {
        try! realm.write {
            realm.add(menu)
        }
    }
    
    static func addRequ(_ menu : Menu){
        try! realm.write {
            menu.menuRequired.append(MenuRequired())
            //realm.add(menu.menuRequired)
            
        }
    }
    
    static func delRequ(_ menu : Menu , Index : Int){
        try! realm.write {
            realm.delete(menu.menuRequired[Index])
            
        }
    }
    
    static func addRequList(_ menu : Menu  , Index : Int){
        try! realm.write {
            menu.menuRequired[Index].menuRequiredList.append(MenuRequiredList())
            realm.add(menu.menuRequired[Index].menuRequiredList)
            
        }
    }
    
    static func delRequList(_ menu : Menu , Index : Int , ListIndex : Int ){
        try! realm.write {
            realm.delete(menu.menuRequired[Index].menuRequiredList[ListIndex])
        }
    }
    
    static func addOption(_ menu : Menu ){
        try! realm.write {
            menu.menuOptions.append(MenuOption())
        }
    }
    
    static func delOption(_ menu : Menu , Index : Int){
        try! realm.write {
            menu.menuOptions.remove(at: Index)
        }
    }
    
    static func editMenu(_ menu : Menu , menuImage : NSData , menuName : String ,menuDefaultPrice : Int , menuRequireds : [MenuRequired] , menuOptions : [MenuOption] ){
        try! realm.write {
            menu.menuImage = menuImage
            menu.menuName = menuName
            menu.menuDefaultPrice = menuDefaultPrice
            
            print("menuRequ count : \(menuRequireds.count)" )
            if(menuRequireds.count > 0){
                for count in 1...menuRequireds.count{
                    menu.menuRequired[count-1].menuRequitedTilte = menuRequireds[count-1].menuRequitedTilte
                    menu.menuRequired[count-1].menuRequiredList = menuRequireds[count-1].menuRequiredList
                    if(menuRequireds[count-1].menuRequiredList.count > 0){
                        print("menuList count : \(menuRequireds[count-1].menuRequiredList.count)")
                        for listCount in 1...menuRequireds[count-1].menuRequiredList.count {
                            menu.menuRequired[count-1].menuRequiredList[listCount-1].menuRequiredTitle = menuRequireds[count-1].menuRequiredList[listCount-1].menuRequiredTitle
                            
                            menu.menuRequired[count-1].menuRequiredList[listCount-1].menuPrice = menuRequireds[count-1].menuRequiredList[listCount-1].menuPrice
                        }
                    }
                }
            }
            //menu.menuRequired.removeAll()
            //menu.menuRequired.append(objectsIn: menuRequireds)
            //menu.menuOptions.removeAll()
            //menu.menuOptions.append(objectsIn: menuOptions)
            
        }
    }
}

class Store : Object {
    
    @objc dynamic var id : String = ""
    @objc dynamic var storeMainImage: NSData? = nil
    @objc dynamic var storeName: String = "Null"
    @objc dynamic var storeCategory : String = "한식"
    @objc dynamic var minDelivery: Int = 0
    @objc dynamic var payMethod : String = "Null"
    @objc dynamic var minTime: Int = 0
    @objc dynamic var tip: Int = 0
    @objc dynamic var like : Bool = false
    
    var menus = List<Menu>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Store {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Store> {
        realm.objects(Store.self)
    }
    
    static func findMenuAll() -> Results<Menu> {
        realm.objects(Menu.self)
    }
    
    static func findStore(storeName : String ) -> Results<Store>{
        return realm.objects(Store.self).filter("storeName == '\(storeName)'")
    }
    
    // realm객체에 값을 추가
    static func addStore(_ store: Store) {
        try! realm.write {
            realm.add(store)
        }
    }
    
    // realm객체의 값을 삭제
    static func delStore(_ store: Store) {
        try! realm.write {
            realm.delete(store)
        }
    }
    
    // realm객체의 값을 업데이트
    static func editStore(store: Store, storeName: String, storeCategory : String ,minDelivery: Int, payMethod: String ,minTime: Int, tip:Int  ) {
        try! realm.write {
            store.storeName = storeName
            store.storeCategory = storeCategory
            store.minDelivery = minDelivery
            store.payMethod = payMethod
            store.minTime = minTime
            store.tip = tip
          
        }
    }
    
    static func editStoreLike(store : Store , like : Bool){
        try! realm.write{
            store.like = like
        }
    }
}
