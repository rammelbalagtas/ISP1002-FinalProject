//
//  Pizza.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-10.
//

import Foundation

class Pizza {
    
    private(set) var name: String
    private(set) var description: String
    
//    private(set) var size: String
//    private(set) var crust: String
//
//    private(set) var sauceList: [Sauce]()
//    private(set) var meatList: [Meat]()
//    private(set) var vegetableList:[Vegetable]()
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
