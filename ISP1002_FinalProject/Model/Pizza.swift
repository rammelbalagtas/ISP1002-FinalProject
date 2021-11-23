//
//  Pizza.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-10.
//

import Foundation

class Pizza {
    
    private(set) var name: String
    private(set) var description: String?
    private(set) var price: Double?
    private(set) var image: String?
    private(set) var size: String?
    private(set) var crust: String?
    private(set) var sauceList: [Sauce] = []
    private(set) var meatList: [Meat] = []
    private(set) var vegetableList:[Vegetable] = []
    
    init(name: String, description: String, price: Double, image: String) {
        self.name = name
        self.description = description
        self.price = price
        self.image = image
    }
    
    init(name: String){
        self.name = name
    }
    
    func setSize(size: String) {
        self.size = size
    }
    
    func setCrust(crust: String) {
        self.crust = crust
    }
}
