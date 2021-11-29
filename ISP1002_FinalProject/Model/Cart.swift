//
//  Cart.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-21.
//

import Foundation

class Cart {
    
    // URL for extracting the archived data
    let cartPizzaListURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent(PizzaDataConfiguration.cartListArchiveFile)
    }()
    
    private(set) var pizzaList = [Pizza]()
    private(set) var subTotal: Double
    private(set) var tax: Double
    private(set) var total: Double
    private let taxRate: Double = 0.13
    
    init() {
        
        // extract data from archive
        do {
            let data = try Data(contentsOf: cartPizzaListURL)
            pizzaList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Pizza]
        } catch let err {
            print(err.localizedDescription) //will print an error message when running app for the first time
        }
        
        subTotal = 0.0
        tax = 0.0
        total = 0.0
        
        if !pizzaList.isEmpty {
            computeTotal()
        }
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
        for pizza in pizzaList {
            subTotal = subTotal + ((Double(pizza.price)) * (Double(pizza.quantity)))
        }
        tax = subTotal * taxRate
        total = subTotal + tax
    }
    
    func deleteList() {
        initTotal()
        self.pizzaList = []
        saveList()
    }
    
    func initTotal() {
        subTotal = 0.0
        tax = 0.0
        total = 0.0
    }
    
    // Update list of orders in archive
    func saveList(){
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: pizzaList, requiringSecureCoding: false)
            try data.write(to: cartPizzaListURL)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
}
