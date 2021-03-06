//
//  PizzaConfigurationData.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-21.
//

import Foundation

class PizzaDataConfiguration {
    
    static let pizzaSize: [String] = ["Small (10\")", "Medium (12\")", "Extra (14\")", "X-Large (16\")"]
    static let pizzaCrust: [String] = ["Original Hand Tossed", "Hand Tossed Thin", "Crunchy Thin Crust", "Gluten Free Crust"]
    static let toppingLevel: [String] = ["None", "Less", "Normal", "Extra", "Double Extra"]
    static let sauceTopping: [String] = ["BBQ Sauce", "Alfredo Sauce", "Hearty Marinara Sauce", "Ranch Dressing", "Garlic Parmesan"]
    static let meatTopping: [String] = ["Pepperoni", "Prawn", "Beef", "Ham", "Bacon", "Chicken"]
    static let vegetableTopping: [String] = ["Black Olives", "Green Olives", "Green Pepper", "Mushroom", "Pineapple", "Onion", "Tomatoes", "Jalapeno Peppers", "Baby Spinach"]
    static let specialPizza = [
        Pizza(name: "Tuscan Pesto", description: "Pesto Sauce, Grilled Chicken, Roasted Red Peppers", price: 10.0, image: "pizza1"),
        Pizza(name: "Veggie", description: "Fresh Mushroom, Green Peppers, Spanish Onions", price: 12.0, image: "pizza2"),
        Pizza(name: "Super Hawaiian", description: "Smoked Ham, Pineapple, Bacon", price: 14.0, image: "pizza3"),
        Pizza(name: "Meat Supreme", description: "Pepperoni, Bacon, Ground Beef, Spicy Sauce", price: 16.0, image: "pizza4"),
        Pizza(name: "Deluxe", description: "Pepperoni, Fresh Mushrooms, Green Peppers, Bacon, Sliced Tomatoes", price: 18.0, image: "pizza5")
    ]
    static let pizzaBasePrice = 10.0
    static let pizzaMaxQty = 10
    static let pizzaMinQty = 1
    static let customPizzaName = "Build Your Own Pizza"
    
    static let orderListArchiveFile = "orderlist.archive"
    static let cartListArchiveFile = "cart.archive"
    
    static func buildToppingDescription(pizza: Pizza) -> String {
        
        var description = ""
        if let _ = pizza.pizzaDescription {
            description = "\(pizza.pizzaDescription!)\n\nAdditional Toppings:"
        } else {
            description = "Toppings:"
        }
        
        var sauceText = ""
        for sauce in pizza.sauceList {
            if sauce.level != "None" {
                if sauceText.isEmpty {
                    sauceText = sauce.name
                } else {
                    sauceText = "\(sauceText), \(sauce.name)"
                }
            }
        }
        
        if sauceText != "" {
            description = "\(description)\nSauce: \(sauceText)"
        }
        
        var meatText = ""
        for meat in pizza.meatList {
            if meat.level != "None" {
                if meatText.isEmpty {
                    meatText = meat.name
                } else {
                    meatText = "\(meatText), \(meat.name)"
                }
               
            }
        }
        
        if meatText != "" {
            description = "\(description)\nMeat: \(meatText)"
        }
        
        var vegetableText = ""
        for vegetable in pizza.vegetableList {
            if vegetable.level != "None" {
                if vegetableText.isEmpty {
                    vegetableText = vegetable.name
                } else {
                    vegetableText = "\(vegetableText), \(vegetable.name)"
                }
            }
        }
        
        if vegetableText != "" {
            description = "\(description)\nVegetable: \(vegetableText)"
        }
        
        if sauceText == "" && meatText == "" && vegetableText == "" {
            description = "\(description) None"
        }
        return description
        
    }
}
