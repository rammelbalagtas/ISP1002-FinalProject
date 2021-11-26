//
//  ToppingList.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-14.
//

import Foundation

class ToppingList {
    
    var sauceList = [Sauce]()
    var meatList = [Meat]()
    var vegetableList = [Vegetable]()
    
//    init(sauceList: [Topping], meatList: [Topping], vegetableList: [Topping]) {
    init() {
        
        self.sauceList.append(Sauce(name: "Sauce 1", level: "level"))
        self.sauceList.append(Sauce(name: "Sauce 2", level: "level"))
        self.sauceList.append(Sauce(name: "Sauce 3", level: "level"))
        self.sauceList.append(Sauce(name: "Sauce 4", level: "level"))
        self.sauceList.append(Sauce(name: "Sauce 5", level: "level"))
        
        self.meatList.append(Meat(name: "Meat 1", level: "level"))
        self.meatList.append(Meat(name: "Meat 2", level: "level"))
        self.meatList.append(Meat(name: "Meat 3", level: "level"))
        self.meatList.append(Meat(name: "Meat 4", level: "level"))
        self.meatList.append(Meat(name: "Meat 5", level: "level"))
        
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        
    }
}
