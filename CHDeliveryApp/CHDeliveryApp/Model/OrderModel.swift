//
//  OrderModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/12.
//

import Foundation
import RealmSwift

class Order : Object {
    @objc dynamic var storeName = ""
    var stores = List<Store>()
    
}

extension Order {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Order> {
        realm.objects(Order.self)
    }

    // realm객체에 값을 추가
    static func addOrder(_ order: Order) {
        try! realm.write {
            
            realm.add(order)
        }
    }
    
}
