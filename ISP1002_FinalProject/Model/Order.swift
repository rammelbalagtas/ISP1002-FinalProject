//
//  Order.swift
//  This class contains all the properties and behavior related to a order object
//
//  Created by Rammel on 2021-11-21.
//

import Foundation

class Order: NSObject, NSCoding {
    
    private(set) var orderId: Int
    private(set) var status: String
    private(set) var pizzaList: [Pizza]
    private(set) var subTotal: Double
    private(set) var tax: Double
    private(set) var total: Double
    private let taxRate: Double = 0.13
    
    init(status: String, pizzaList: [Pizza], subTotal: Double, tax: Double, total: Double) {
        self.orderId = Int.random(in: 1..<9999)
        self.status = status
        self.pizzaList = pizzaList
        self.subTotal = subTotal
        self.tax = tax
        self.total = total
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(orderId, forKey: "orderId")
        coder.encode(status, forKey: "status")
        coder.encode(pizzaList, forKey: "pizzaList")
        coder.encode(subTotal, forKey: "subTotal")
        coder.encode(tax, forKey: "tax")
        coder.encode(total, forKey: "total")
    }
    
    required init?(coder: NSCoder) {
        orderId = coder.decodeInteger(forKey: "orderId")
        status = coder.decodeObject(forKey: "status") as! String
        pizzaList = coder.decodeObject(forKey: "pizzaList") as! [Pizza]
        subTotal = coder.decodeDouble(forKey: "subTotal")
        tax = coder.decodeDouble(forKey: "tax")
        total = coder.decodeDouble(forKey: "total")
        super.init()
    }
    
    func addPizza(pizza: Pizza) {
        pizzaList.append(pizza)
        computeTotal()
    }
    
    func removePizza(index: Int) {
        pizzaList.remove(at: index)
        if !pizzaList.isEmpty {
            computeTotal()
        } else {
            initTotal()
        }
    }
    
    func computeTotal() {
        initTotal()
        for pizza in pizzaList {
            subTotal = subTotal + ((Double(pizza.price)) * (Double(pizza.quantity)))
        }
        tax = subTotal * taxRate
        total = subTotal + tax
    }
    
    func deleteList() {
        initTotal()
        self.pizzaList = []
    }
    
    func initTotal() {
        subTotal = 0.0
        tax = 0.0
        total = 0.0
    }
}
