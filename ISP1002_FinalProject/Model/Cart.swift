//
//  Cart.swift
//  This class contains all the properties and behavior related to a cart object
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
    private(set) var subTotal: Double = 0.0
    private(set) var tax: Double = 0.0
    private(set) var total: Double = 0.0
    private let taxRate: Double = 0.13
    
    init() {
        // extract data from archive
        do {
            let data = try Data(contentsOf: cartPizzaListURL)
            pizzaList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Pizza]
        } catch let err {
            print(err.localizedDescription) //will print an error message when running app for the first time
        }
        
        if !pizzaList.isEmpty {
            computeTotal()
        }
    }
    
    // Method for adding pizza (includes total recomputation and saving to archive)
    func addPizza(pizza: Pizza) {
        pizzaList.append(pizza)
        computeTotal()
    }
    
    // Method for removing pizza (includes total recomputation and saving to archive)
    func removePizza(index: Int) {
        pizzaList.remove(at: index)
        if !pizzaList.isEmpty {
            computeTotal()
        } else {
            initTotal()
            saveList()
        }
    }
    
    // Total amount will always be recomputed for newly created or modified cart
    func computeTotal() {
        initTotal()
        for pizza in pizzaList {
            subTotal = subTotal + ((Double(pizza.price)) * (Double(pizza.quantity)))
        }
        tax = subTotal * taxRate
        total = subTotal + tax
        saveList()
    }
    
    // Function for deleting the entire cart (empty pizza list)
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
