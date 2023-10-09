//
//  CartViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import SwiftUI

class CartViewModel : ObservableObject {
    //var ShopMenuCart = Cart(Price: 1000, Count: 1, Total: 0)
    
    @Published private var shopMenuCart: Cart = Cart()
    
    var Count: Int {
        shopMenuCart.Count
    }
    
    var Price: Int {
        shopMenuCart.Price
    }
    
    var Total: Int {
        shopMenuCart.Total
    }
    
    func UpCount(){
        shopMenuCart.UpCount()
    }
    
    func DownCount(){
        shopMenuCart.DownCount()
    }
    
}
