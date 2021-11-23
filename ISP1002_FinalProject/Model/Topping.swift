//
//  Topping.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-14.
//

import Foundation

class Topping {
    
    private(set) var type: String
    private(set) var name: String
    private(set) var level: String

    init(type: String, name: String, level: String) {
        self.type = type
        self.name = name
        self.level = level
    }
    
    func setLevel(level: String) {
        self.level = level
    }
    
}
