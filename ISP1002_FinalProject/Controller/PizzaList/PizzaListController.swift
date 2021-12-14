//
//  PizzaListTableViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-10.
//

import UIKit

class PizzaListController: UITableViewController {
    
    let pizzaListCellIdentifier = "PizzaListCell"
    var pizzaList: [Pizza] = []
    
    override func viewWillAppear(_ animated: Bool) {
        for pizza in PizzaDataConfiguration.specialPizza {
            pizzaList.append(pizza)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: pizzaListCellIdentifier, for: indexPath) as? PizzaListCell else {
            fatalError("Unable to dequeue PizzaListCell")
        }
        // Set value of each cell
        let pizza = pizzaList[indexPath.row]
        cell.nameLabel!.text = pizza.name + " ($\(String(pizza.price)))"
        cell.descriptionLabel!.text = pizza.pizzaDescription
        cell.pizzaImage!.image = UIImage(named: pizza.image!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildSpecialPizzaSegue" {
            let destination = segue.destination as! SizeTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.pizza = nil
                destination.pizza = Pizza(name: pizzaList[indexPath.row].name,
                                          price: pizzaList[indexPath.row].price)
            }
        }
    }

}
