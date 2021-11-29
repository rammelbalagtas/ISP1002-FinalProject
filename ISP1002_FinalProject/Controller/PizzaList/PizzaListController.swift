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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        for pizza in PizzaDataConfiguration.specialPizza {
            pizzaList.append(pizza)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildSpecialPizzaSegue" {
            let destination = segue.destination as! SizeTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.pizza = nil
                destination.pizza = Pizza(name: pizzaList[indexPath.row].name, price: pizzaList[indexPath.row].price)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: pizzaListCellIdentifier, for: indexPath) as? PizzaListCell else {
            fatalError("Unable to dequeue PizzaListCell")
        }
        // Configure the cell...
        let pizza = pizzaList[indexPath.row]
        cell.nameLabel!.text = pizza.name
        cell.descriptionLabel!.text = pizza.pizzaDescription
        cell.pizzaImage! = UIImageView(image: UIImage(named: (pizza.image)!))
        return cell
    }

}
