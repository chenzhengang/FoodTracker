//
//  Conditions.swift
//  FoodTracker
//
//  Created by Chun Kong on 2018/4/28.
//  Copyright © 2018年 chenzhengang. All rights reserved.
//

import UIKit
import os.log

class Conditions: NSObject {
    //MARK: Initialization
    init?(name: String, photo: UIImage?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.selected = 0
    }
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var selected: Int

    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
    }
  
}
