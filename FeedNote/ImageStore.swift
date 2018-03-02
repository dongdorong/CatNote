//
//  ImageStore.swift
//  FeedNote
//
//  Created by Dona Kang on 2018. 2. 25..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
    
    func deletImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
    }
    
}
