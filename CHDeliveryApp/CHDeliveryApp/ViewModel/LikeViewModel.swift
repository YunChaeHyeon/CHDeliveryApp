//
//  LikeViewModel.swift
//  CHDeliveryApp
//
//  Created by 윤채현 on 2023/12/11.
//

import Foundation
import SwiftUI

class LikeViewModel: ObservableObject {
    
    @Published var likeStores: [Like] = Array(Like.findAll())
    @Published var storeName = ""
    
    @Published var deleteLike = true
    
    func addLike(add: Store){
        
        let like = Like()
        
        like.id = UUID().uuidString
        like.storeName = storeName
        
        like.stores.append(add)
        
        Like.addLike(like)
    }
    
    func delLike(old : Store) -> Bool{
        var findLikeStore : [Like] = Array(Like.findStore(storeData: old))
        Like.delLikeStore(findLikeStore[0])
        
        return false
    }
}
