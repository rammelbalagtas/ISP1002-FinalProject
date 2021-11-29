//
//  Pizza.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-10.
//

import Foundation

class Pizza: NSObject, NSCoding {
    
    private(set) var name: String
    private(set) var pizzaDescription: String?
    private(set) var image: String?
    private(set) var size: String?
    private(set) var crust: String?
    private(set) var price: Double
    private(set) var quantity: Int = 0
    private(set) var sauceList: [Sauce] = []
    private(set) var meatList: [Meat] = []
    private(set) var vegetableList:[Vegetable] = []
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(pizzaDescription, forKey: "pizzaDescription")
        coder.encode(image, forKey: "image")
        coder.encode(size, forKey: "size")
        coder.encode(crust, forKey: "crust")
        coder.encode(price, forKey: "price")
        coder.encode(quantity, forKey: "quantity")
        coder.encode(sauceList, forKey: "sauceList")
        coder.encode(meatList, forKey: "meatList")
        coder.encode(vegetableList, forKey: "vegetableList")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        pizzaDescription = coder.decodeObject(forKey: "pizzaDescription") as? String
        image = coder.decodeObject(forKey: "image") as? String
        size = coder.decodeObject(forKey: "size") as? String
        crust = coder.decodeObject(forKey: "crust") as? String
        price = coder.decodeDouble(forKey: "price")
        quantity = coder.decodeInteger(forKey: "quantity")
        sauceList = coder.decodeObject(forKey: "sauceList") as! [Sauce]
        meatList = coder.decodeObject(forKey: "meatList") as! [Meat]
        vegetableList = coder.decodeObject(forKey: "vegetableList") as! [Vegetable]
        super.init()
    }
    
    init(name: String, description: String, price: Double, image: String) {
        self.name = name
        self.pizzaDescription = description
        self.price = price
        self.image = image
    }
    
    init(name: String, price: Double){
        self.name = name
        self.price = price
    }
    
    func setSize(size: String) {
        self.size = size
    }
    
    func setCrust(crust: String) {
        self.crust = crust
    }
    
    func setQuantity(quantity: Int) {
        self.quantity = quantity
    }
    
    func setSauceList(sauceList: [Sauce]) {
        self.sauceList = sauceList
    }
    
    func appendSauce(sauce: Sauce) {
        self.sauceList.append(sauce)
    }
    
    func setVegetableList(vegetableList: [Vegetable]) {
        self.vegetableList = vegetableList
    }
    
    func appendVegetable(vegetable: Vegetable) {
        self.vegetableList.append(vegetable)
    }
    
    func setMeatList(meatList: [Meat]) {
        self.meatList = meatList
    }
    
    func appendMeat(meat: Meat) {
        self.meatList.append(meat)
    }
    
}
