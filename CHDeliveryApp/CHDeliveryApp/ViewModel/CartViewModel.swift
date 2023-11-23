//
//  CartViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import SwiftUI

class CartViewModel : ObservableObject {
    @Published var carts: [Cart] = Array(Cart.findAll())
    
    @Published var storeName : String = ""
    @Published var deliveryTime : Int = 0
    @Published var menuName : String = ""
    @Published var menuImage : NSData? = nil
    @Published var price : Int = 0
    @Published var count : Int = 1
    @Published var total : Int = 0
    
    func addCart() {
        let cart = Cart()
        cart.storeName = storeName
        cart.deliveryTime = deliveryTime
        cart.menuName = menuName
        cart.menuImage = menuImage
        cart.price = price
        cart.count = count
        cart.total = total
        
        self.carts.append(cart)
    }
    
    func delCart(old : Cart) {
        Cart.delCart(old)
    }
    
    func editCart(old : Cart) -> Void {
        Cart.editCart(cart: old, _price: price, _count: count, _total: total)
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
