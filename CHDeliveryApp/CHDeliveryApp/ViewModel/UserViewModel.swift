//
//  UserViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/09.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = Array(User.findAll())

    func add(name: String) -> Void {
        guard !name.isEmpty else { return }
        let user = User()
        user.name = name
        self.users.append(user)
        User.addMemo(user)
    }
    
    func delete(old: User) -> Void {
        User.delMemo(old)
    }

    func refreshMemo() -> Void {
        self.users = Array(User.findAll())
    }

    func editMemo(old: User, name: String) -> Void {
        guard !name.isEmpty else { return }
        User.editMemo(user: old, name: name)
    }
    
}
