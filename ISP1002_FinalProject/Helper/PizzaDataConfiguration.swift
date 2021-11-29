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
    
    static let orderListArchiveFile = "ordertest2.archive"
    static let cartListArchiveFile = "cartest2.archive"
}
