//
//  CustomizePizzaController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-12.
//

import UIKit

class CustomizePizzaController: UITableViewController {
    
    @IBOutlet var pizzaNameLabel: UILabel!
    @IBOutlet var pizzaSizeLabel: UILabel!
    @IBOutlet var pizzaCrustLabel: UILabel!
    
    let toppingListCellIdentifier = "ToppingListCell"
    var mode: String?
    var pizza: Pizza?
    var sauceList = [Sauce]()
    var meatList = [Meat]()
    var vegetableList = [Vegetable]()

    @IBAction func addQuantity(_ sender: UIButton) {
        print("ok")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == "Create" {
            setData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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

    // Create a standard header that includes the returned text.
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
    
    func setData() {
        
        pizzaNameLabel.text = pizza?.name
        pizzaSizeLabel.text = pizza?.size
        pizzaCrustLabel.text = pizza?.crust
        
        for sauce in PizzaDataConfiguration.sauceTopping {
            self.sauceList.append(Sauce(name: sauce, level: "None"))
        }
        
        for meat in PizzaDataConfiguration.meatTopping {
            self.meatList.append(Meat(name: meat, level: "Normal"))
        }
        
        for vegetable in PizzaDataConfiguration.vegetableTopping {
            self.vegetableList.append(Vegetable(name: vegetable, level: "Normal"))
        }
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
