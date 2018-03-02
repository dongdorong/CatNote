//
//  Item.swift
//  FeedNote
//
//  Created by Dona on 2018. 1. 26..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class Item: NSObject {
    var title: String
    var date: Date
    var location: String
    let itemKey: String
    
    init(title: String, location: String) {
        self.title = title
        self.date = Date()
        self.location = location
        self.itemKey = NSUUID().uuidString
        
        super.init()
    }
    
    // 임의의 데이터 생성
    convenience init(random: Bool = false) {
        if random {
            let title = ["오늘따라 기분이안좋은지 밥의양이 많이 줄었다.", "요즘 안보이는데 무슨일이 있는 것인지 ...????", "밥을 준 것이 고마웠는지 자기 새끼들을 데리고와줬다!!"]
            let location = ["안양천서로 311, 만안구, 경기도 대한민국", "서울특별시 금천구 가산동 371-37", "경기도 광명시 일직동 154-2"]
            
            var idx = arc4random_uniform(UInt32(title.count))
            let randomTitle = title[Int(idx)]
            
            idx = arc4random_uniform(UInt32(location.count))
            let randomLocation = location[Int(idx)]
            
            let titleName = "\(randomTitle)"
            let locationName = "\(randomLocation)"
            
            self.init(title: titleName, location: locationName)
        
        } else {
            self.init(title: "", location: "")
        }
    }
    
}
