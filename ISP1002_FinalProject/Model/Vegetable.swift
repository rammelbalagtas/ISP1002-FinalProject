//
//  Vegetable.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-14.
//

import Foundation

class Vegetable : Topping {
    
    init(name: String, level: String) {
        super.init(type: "Vegetable", name: name, level: level)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
