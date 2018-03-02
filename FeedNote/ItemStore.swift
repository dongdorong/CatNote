//
//  itemStore.swift
//  FeedNote
//
//  Created by Dona on 2018. 1. 27..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class ItemStore{
    var allItem = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItem.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItem.index(of: item) {
            allItem.remove(at: index)
        }
    }
    
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
}
