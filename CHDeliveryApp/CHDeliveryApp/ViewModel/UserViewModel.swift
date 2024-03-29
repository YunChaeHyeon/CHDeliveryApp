//
//  UserViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/10/09.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users: [User] = Array(User.findAll())
    
    func getname() -> String{
        var name = ""
        if(users.isEmpty){
            name = "닉네임"
        }else{
            name = users[0].name
        }
        return name
    }
    
    func imageInit() -> Image {
        var image = Image("userDefault")
        if(users.first != nil ){
            image = getImage()
        }
        return image
    }
    
    func getImage() -> Image {
        var image = Image("userDefault")
        if(users.first != nil){
            if(users[0].image == nil) { return image }
            let userImage2 = UIImage(data: users[0].image! as Data)
            image = Image(uiImage: userImage2!)
        }
        
        return image
    }
    
    func getUIImage() -> UIImage {
        var useruiImage = UIImage(named: "userDefault")
        if(users.first != nil){
            if(users[0].image == nil) { return useruiImage! }
            useruiImage = UIImage(data: users[0].image! as! Data)!
        }

        return useruiImage!
    }

    func addUser(name: String) -> Void {
        guard !name.isEmpty else { return }
        let user = User()
        user.name = name
        self.users.append(user)
        User.addUser(user)
    }
    
    func addUser(name : String , userImage : NSData ) {
        let user = User()
        user.name = name
        user.image = userImage
        self.users.append(user)
        User.addUser(user)
    }
    
    func delUser(old: User) -> Void {
        User.delUser(old)
    }

    func refreshUser() -> Void {
        self.users = Array(User.findAll())
    }

    func editUser(old: User, name: String , userImage: NSData) -> Void {
        guard !name.isEmpty else { return }
        User.editUser(user: old, name: name , userImage: userImage)
    }
    
}
