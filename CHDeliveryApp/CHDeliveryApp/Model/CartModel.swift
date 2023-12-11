//
//  CartModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import Foundation
import RealmSwift

class CartMenu : Object {
    
    @objc dynamic var menuName : String = ""
    @objc dynamic var menuImage : NSData? = nil
    @objc dynamic var DefaultPrice : Int = 0
    @objc dynamic var price : Int = 0
    @objc dynamic var count : Int = 1
    @objc dynamic var total : Int = 0
}

class Cart : Object {
    @objc dynamic var storeName : String = ""
    @objc dynamic var deliveryTime : Int = 0
    
    var cartMenus = List<CartMenu>()
}

extension Cart {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Cart> {
        realm.objects(Cart.self)
    }
    
    // realm객체에 값을 추가
    static func addCart(_ cart: Cart) {
        try! realm.write {
            realm.add(cart)
        }
    }
    
    // realm객체의 값을 삭제
    static func delCart(_ cart: Cart) {
        try! realm.write {
            realm.delete(cart)
        }
    }

    static func delCartMenu(_ cartMenu: CartMenu){
        try! realm.write {
            realm.delete(cartMenu)
        }
    }
    
    // realm객체의 값을 업데이트
    static func editCartMenu(cart: Cart , cartMenu: CartMenu) {
        try! realm.write {
            cart.cartMenus.append(cartMenu)

        }
    }
    
}
