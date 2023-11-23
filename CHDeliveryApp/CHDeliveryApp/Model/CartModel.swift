//
//  CartModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import Foundation
import RealmSwift

class Cart : Object {
    @objc dynamic var storeName : String = ""
    @objc dynamic var deliveryTime : Int = 0
    @objc dynamic var menuName : String = ""
    @objc dynamic var menuImage : NSData? = nil
    @objc dynamic var price : Int = 0
    @objc dynamic var count : Int = 1
    @objc dynamic var total : Int = 0
    
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
    
    // realm객체의 값을 업데이트
    static func editCart(cart: Cart , _price : Int , _count : Int , _total : Int) {
        try! realm.write {
            cart.price = _price
            cart.count = _count
            cart.total = _total

        }
    }
    

}
