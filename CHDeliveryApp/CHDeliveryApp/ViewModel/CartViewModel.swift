//
//  CartViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import SwiftUI
import RealmSwift

class CartViewModel : ObservableObject {
    @Published var carts: [Cart] = Array(Cart.findAll())
    
    
    @Published var storeName : String = ""
    @Published var deliveryTime : Int = 0
    @Published var menuName : String = ""
    @Published var menuImage : NSData? = nil
    @Published var DefaultPrice : Int = 0
    @Published var price : Int = 0
    @Published var count : Int = 1
    @Published var total : Int = 0
    
    @Published var cartMenus : [CartMenu] = Array<CartMenu>()
    
    func addCartMenu(){
        let cartMenu = CartMenu()
        cartMenu.menuName = menuName
        cartMenu.menuImage = menuImage
        cartMenu.DefaultPrice = DefaultPrice
        cartMenu.price = price
        cartMenu.count = count
        cartMenu.total = total
        
        self.cartMenus.append(cartMenu)
        
    }

    
    func reAddCartMenu() -> CartMenu {
        var cartMenu = CartMenu()
        cartMenu.menuName = menuName
        cartMenu.menuImage = menuImage
        cartMenu.DefaultPrice = DefaultPrice
        cartMenu.price = price
        cartMenu.count = count
        cartMenu.total = total
        return cartMenu
    }
    
    func addCartMenu(old : Cart , addCartMenu: CartMenu) -> Void {

        Cart.editCartMenu(cart: old, cartMenu: addCartMenu)
    }
    
    func delCartMenu(obj : CartMenu){
        Cart.delCartMenu(obj)
    }
    
    func addCart() {
        let cart = Cart()
        cart.storeName = storeName
        cart.deliveryTime = deliveryTime
        cart.cartMenus.append(objectsIn: cartMenus)
        self.carts.append(cart)
        Cart.addCart(cart)
    }
    
    func delCart(old : Cart) {
        Cart.delCart(old)
    }
    
    func delViewModelCartMenu(cartIndex : Int ,removeMenuIndex: Int){
        let realm = try! Realm()
        try! realm.write {
        carts[cartIndex].cartMenus.remove(at: removeMenuIndex)
        }
    }
    
    func delViewModelCart(removeIndex : Int){
        carts.remove(at: removeIndex)
    }
    
    func UpCount(){
        count = count + 1
        total = price*count
    }

    func DownCount(){
        if(count < 2) {return}
        count = count - 1
        total = price*count
    }
    
}
