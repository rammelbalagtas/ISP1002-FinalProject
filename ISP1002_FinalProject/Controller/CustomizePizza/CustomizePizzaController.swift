//
//  CustomizePizzaController.swift
//  This is the table view controller for the customizing new and existing pizza item
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
    @IBOutlet var btnAddToCart: UIButton!
    
    // actions
    @IBAction func actionAddPizza(_ sender: UIButton) { increaseQuantity() }
    @IBAction func actionLessPizza(_ sender: UIButton) { decreaseQuantity() }
    @IBAction func actionAddToCart(_ sender: UIButton) { addToCart() }
    
    let toppingListCellIdentifier = "ToppingListCell"
    var displayMode: DisplayMode?
    var pizza: Pizza?

    override func viewDidLoad() {
        super.viewDidLoad()
        if displayMode == .new {
            // building a new pizza
            setInitialData()
        } else {
            // pizza data passed from segue (either from cart or active order)
            pizzaNameLabel.text = pizza?.name
            pizzaSizeLabel.text = pizza?.size
            pizzaCrustLabel.text = pizza?.crust
            if let quantity = pizza?.quantity {
                pizzaQuantity.text = String(quantity)
            }
            btnAddToCart.setTitle("Save", for: .normal)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // topping sections (Sauce, Meat, Vegetable)
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.pizza!.sauceList.count
        case 1:
            return self.pizza!.meatList.count
        case 2:
            return self.pizza!.vegetableList.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: toppingListCellIdentifier, for: indexPath) as? ToppingListCell else {
            fatalError("Unable to dequeue ToppingListCell")
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        // set values for each cell
        switch indexPath.section {
        case 0:
            let sauce = self.pizza!.sauceList[indexPath.row]
            cell.nameLabel!.text = sauce.name
            cell.levelLabel!.text = sauce.level
        case 1:
            let meat = self.pizza!.meatList[indexPath.row]
            cell.nameLabel!.text = meat.name
            cell.levelLabel!.text = meat.level
        case 2:
            let vegetable = self.pizza!.vegetableList[indexPath.row]
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToHome" {
            let destination = segue.destination as! HomeViewController
            destination.cart.addPizza(pizza: pizza!)
            destination.cart.saveList()
            pizza = nil
        } else if segue.identifier == "unwindToOrderSummary" {
            let destination = segue.destination as! OrderSummaryTableViewController
            if let cart = destination.cart {
                cart.computeTotal()
            } else if let order = destination.order {
                order.computeTotal()
            }
        }
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
            self.pizza?.appendSauce(sauce: Sauce(name: sauce, level: "None"))
        }
        
        for meat in PizzaDataConfiguration.meatTopping {
            self.pizza?.appendMeat(meat: Meat(name: meat, level: "None"))
        }
        
        for vegetable in PizzaDataConfiguration.vegetableTopping {
            self.pizza?.appendVegetable(vegetable: Vegetable(name: vegetable, level: "None"))
        }
    }
    
    func increaseQuantity() {
        if var quantity = pizza?.quantity {
            if quantity < PizzaDataConfiguration.pizzaMaxQty { //max quantity is 10 (refer to PizzaDataConfiguration class)
                quantity += 1
                self.pizza?.setQuantity(quantity: quantity)
                pizzaQuantity.text = String(quantity)
            }
        }
    }
    
    func decreaseQuantity() {
        if var quantity = pizza?.quantity {
            if quantity > PizzaDataConfiguration.pizzaMinQty { //minimum quantity = 1 (refer to PizzaDataConfiguration class)
                quantity -= 1
                self.pizza?.setQuantity(quantity: quantity)
                pizzaQuantity.text = String(quantity)
            }
        }
    }
    
    // This method handles:
    // 1. Adding a new order to the cart
    // 2. Updating a cart or order item
    func addToCart() {
        if validateData() {
            if displayMode == .new {
                displayMessage(title: "",
                               message: "You order is added to the cart",
                               handler: { action in self.performSegue(withIdentifier: "unwindToHome", sender: self) })
            } else {
                displayMessage(title: "",
                               message: "Your order is updated",
                               handler: { action in self.performSegue(withIdentifier: "unwindToOrderSummary", sender: self) })
            }
        }
    }
    
    // Perform simple validation prior to adding item to the cart
    func validateData() -> Bool {
        //Toppings are only required for pizza name = "Build Your Own Pizza"
        if pizza!.name != PizzaDataConfiguration.customPizzaName {
            return true
        }
        var hasSauce: Bool = false
        var hasMeat: Bool = false
        var hasVegetable: Bool = false
        for sauce in pizza!.sauceList {
            if sauce.level != "None" {
                hasSauce = true
                break
            }
        }
        if !hasSauce {
            displayMessage(title: "Warning", message: "Please add at lease one sauce", handler: nil)
            return false
        }
        for meat in pizza!.meatList {
            if meat.level != "None" {
                hasMeat = true
                break
            }
        }
        if !hasMeat {
            for vegetable in pizza!.vegetableList {
                if vegetable.level != "None" {
                    hasVegetable = true
                    break
                }
            }
            if !hasVegetable {
                displayMessage(title: "Warning", message: "Please add at lease one meat and/or vegetable", handler: nil)
                return false
            }
        }
        return true
    }
    
    // Reusable method for displaying confirmation messages
    func displayMessage(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}

// delegating actions to the main controller for updating the model
extension CustomizePizzaController: CustomizePizza {
    func updateToppingLevel(newLevel: String, section: Int, row: Int) {
        switch section {
        case 0:
            pizza!.sauceList[row].setLevel(level: newLevel)
        case 1:
            pizza!.meatList[row].setLevel(level: newLevel)
        case 2:
            pizza!.vegetableList[row].setLevel(level: newLevel)
        default:
            print("No corresponding section")
        }
    }
}
