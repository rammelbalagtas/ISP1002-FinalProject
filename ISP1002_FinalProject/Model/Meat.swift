//
//  Meat.swift
//  Refer to PizzaDataConfiguration for different types of meat toppings
//
//  Created by Rammel on 2021-11-14.
//

import Foundation

class Meat : Topping {
    
    init(name: String, level: String) {
        super.init(type: "Meat", name: name, level: level)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
