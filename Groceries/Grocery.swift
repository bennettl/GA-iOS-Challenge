//
//  Grocery.swift
//  Groceries
//
//  Created by Lee Bennett on 5/4/16.
//  Copyright © 2016 Bennett. All rights reserved.
//

import Foundation


class Grocery {
    
    var name: String
    var quantity: Int = 1
    var description: String
    var completed: Bool = false
    
    init(name: String, quantity: Int, description: String){
        self.name           = name
        self.quantity       = quantity
        self.description    = description
    }

}
