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

class MenuOption : Object {
    @objc dynamic var menuOptionsTilte : String = ""
    var menuOptionList = List<MenuOptionList>()
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
}

class Store : Object {
    
   
    @objc dynamic var storeMainImage: NSData? = nil
    @objc dynamic var storeName: String = "Null"
    @objc dynamic var storeCategory : String = "한식"
    @objc dynamic var minDelivery: Int = 0
    @objc dynamic var payMethod : String = "Null"
    @objc dynamic var minTime: Int = 0
    @objc dynamic var tip: Int = 0
    @objc dynamic var like : Bool = false
    
    var menus = List<Menu>()
    
}

extension Store {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Store> {
        realm.objects(Store.self)
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
    static func editStore(store: Store, storeName: String, minDelivery: Int, payMethod: String ,minTime: Int, tip:Int ) {
        try! realm.write {
            store.storeName = storeName
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
