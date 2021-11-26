//
//  CustomizePizzaController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-12.
//

import UIKit

class CustomizePizzaController: UITableViewController {
    
    // outlets
    @IBOutlet var pizzaNameLabel: UILabel!
    @IBOutlet var pizzaSizeLabel: UILabel!
    @IBOutlet var pizzaCrustLabel: UILabel!
    @IBOutlet var pizzaQuantity: UILabel!
    
    // actions
    @IBAction func actionAddPizza(_ sender: UIButton) { increaseQuantity() }
    @IBAction func actionLessPizza(_ sender: UIButton) { decreaseQuantity() }
    @IBAction func actionAddToCart(_ sender: UIButton) { addToCart() }
    
    let toppingListCellIdentifier = "ToppingListCell"
    var mode: String?
    var pizza: Pizza?
    var cart = Cart()
    var order: Order?
    var sauceList = [Sauce]()
    var meatList = [Meat]()
    var vegetableList = [Vegetable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == "Create" {
            setInitialData()
        } else {
            // pass data from cart or order
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // topping sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.sauceList.count
        case 1:
            return self.meatList.count
        case 2:
            return self.vegetableList.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: toppingListCellIdentifier, for: indexPath) as? ToppingListCell else {
            fatalError("Unable to dequeue ToppingListCell")
        }
        cell.delegate = self
        cell.indexPath = indexPath
        switch indexPath.section {
        case 0:
            let sauce = sauceList[indexPath.row]
            cell.nameLabel!.text = sauce.name
            cell.levelLabel!.text = sauce.level
        case 1:
            let meat = meatList[indexPath.row]
            cell.nameLabel!.text = meat.name
            cell.levelLabel!.text = meat.level
        case 2:
            let vegetable = vegetableList[indexPath.row]
            cell.nameLabel!.text = vegetable.name
            cell.levelLabel!.text = vegetable.level
        default:
            return cell
        }
        return cell
    }

    // Define header for each topping table
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        var header = ""
        switch section {
        case 0:
            header = "Sauce"
        case 1:
            header = "Meat"
        case 2:
            header = "Vegetables"
        default:
            header = "Header"
        }
        return header
    }
    
    func setInitialData() {
        
        pizzaNameLabel.text = pizza?.name
        pizzaSizeLabel.text = pizza?.size
        pizzaCrustLabel.text = pizza?.crust
        pizza?.setQuantity(quantity: 1)
        if let quantity = pizza?.quantity {
            pizzaQuantity.text = String(quantity)
        }
        
        for sauce in PizzaDataConfiguration.sauceTopping {
            self.sauceList.append(Sauce(name: sauce, level: "None"))
        }
        
        for meat in PizzaDataConfiguration.meatTopping {
            self.meatList.append(Meat(name: meat, level: "None"))
        }
        
        for vegetable in PizzaDataConfiguration.vegetableTopping {
            self.vegetableList.append(Vegetable(name: vegetable, level: "None"))
        }
    }
    
    func increaseQuantity() {
        if var quantity = pizza?.quantity {
            if quantity < PizzaDataConfiguration.pizzaMaxQty { //max quantity is 10
                quantity += 1
                pizza?.setQuantity(quantity: quantity)
                pizzaQuantity.text = String(quantity)
            }
        }
    }
    
    func decreaseQuantity() {
        if var quantity = pizza?.quantity {
            if quantity > PizzaDataConfiguration.pizzaMinQty { //minimum quantity = 1
                quantity -= 1
                pizza?.setQuantity(quantity: quantity)
                pizzaQuantity.text = String(quantity)
            }
        }
    }
    
    func addToCart() {
        if validateData() {
            pizza?.setSauceList(sauceList: sauceList)
            pizza?.setMeatList(meatList: meatList)
            pizza?.setVegetableList(vegetableList: vegetableList)
            cart.addPizza(pizza: pizza!)
            cart.saveList()
            pizza = nil
//            displayMessage(title: "Success", message: "Order successfully added to cart")
            unwindSegue()
        }
    }
    
    func validateData() -> Bool {
        var hasSauce: Bool = false
        var hasMeat: Bool = false
        var hasVegetable: Bool = false
        
        for sauce in sauceList {
            if sauce.level != "None" {
                hasSauce = true
                break
            }
        }
        
        if !hasSauce {
            displayMessage(title: "Warning", message: "Please add at lease one sauce")
            return false
        }
             
        for meat in meatList {
            if meat.level != "None" {
                hasMeat = true
                break
            }
        }
        
        if !hasMeat {
            for vegetable in vegetableList {
                if vegetable.level != "None" {
                    hasVegetable = true
                    break
                }
            }
            
            if !hasVegetable {
                displayMessage(title: "Warning", message: "Please add at lease one meat and/or vegetable")
                return false
            }
        }
        return true
    }
    
    // for returning to home
    func unwindSegue () {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    func displayMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CustomizePizzaController: CustomizePizza {
    func updateToppingLevel(newLevel: String, section: Int, row: Int) {
        switch section {
        case 0:
            sauceList[row].setLevel(level: newLevel)
        case 1:
            meatList[row].setLevel(level: newLevel)
        case 2:
            vegetableList[row].setLevel(level: newLevel)
        default:
            print("No corresponding section")
        }
    }

}
