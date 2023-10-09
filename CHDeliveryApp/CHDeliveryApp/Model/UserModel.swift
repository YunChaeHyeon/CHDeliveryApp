//
//  UserModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/03.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String = "Null"
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

extension User {
    static var configuration = Realm.Configuration(schemaVersion: 3)
    private static var realm = try! Realm(configuration: configuration)

    // realm객체가 타입 프로퍼티이기에 메서드도 타입 메서드로 선언
    // realm객체에 담긴 모든 값을 Results<Memo>의 형태로 조회
    static func findAll() -> Results<User> {
        realm.objects(User.self)
    }
    
    // realm객체에 값을 추가
    static func addMemo(_ user : User) {
        try! realm.write {
            realm.add(user)
        }
    }

    // realm객체의 값을 삭제
    static func delMemo(_ user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }

    // realm객체의 값을 업데이트
    static func editMemo(user: User, name: String) {
        try! realm.write {
            user.name = name
        }
    }

}
