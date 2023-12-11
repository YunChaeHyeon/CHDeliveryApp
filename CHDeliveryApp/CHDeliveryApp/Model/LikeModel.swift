//
//  LikeModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/11.
//

import Foundation
import RealmSwift

class Like : Object {
    @objc dynamic var storeName = ""
    var stores = List<Store>()
    
}

extension Like {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)
    
    static func findAll() -> Results<Like> {
        realm.objects(Like.self)
    }
    
    static func findStore(storeData : Store ) -> Results<Like>{
        let storeName = storeData.storeName
        return realm.objects(Like.self).filter("storeName == '\(storeName)'")
    }
    
    // realm객체에 값을 추가
    static func addLike(_ like: Like) {
        try! realm.write {
            
            realm.add(like)
        }
    }
    
    // realm객체의 값을 삭제
    static func delLikeStore(_ like: Like) {
        try! realm.write {
            realm.delete(like)
        }
    }
}
