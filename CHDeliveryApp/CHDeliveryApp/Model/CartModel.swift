//
//  CartModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/09/27.
//

import Foundation

struct Cart {
    var Price : Int = 17000
    var Count : Int = 1
    var Total : Int = 0
    
    mutating func UpCount(){
        Count = Count + 1
        Total = Price*Count
    }
    
    mutating func DownCount(){
        if(Count < 2) {return}
        Count = Count - 1
        Total = Price*Count
    }
}
