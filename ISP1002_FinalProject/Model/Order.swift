//
//  Order.swift
//  ISP1002_FinalProject
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
        self.orderId = 1
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
        orderId = coder.decodeObject(forKey: "orderId") as! Int
        status = coder.decodeObject(forKey: "status") as! String
        pizzaList = coder.decodeObject(forKey: "pizzaList") as! [Pizza]
        subTotal = coder.decodeObject(forKey: "subTotal") as! Double
        tax = coder.decodeObject(forKey: "tax") as! Double
        total = coder.decodeObject(forKey: "total") as! Double
        super.init()
    }
    
    func addPizza(pizza: Pizza) {
        pizzaList.append(pizza)
        computeTotal()
    }
    
    func removePizza(index: Int) {
        pizzaList.remove(at: index)
        computeTotal()
    }
    
    func computeTotal() {
        for pizza in pizzaList {
            subTotal += (pizza.price! * (Double(pizza.quantity!)))
        }
        tax = subTotal * taxRate
        total = subTotal + tax
    }
}
