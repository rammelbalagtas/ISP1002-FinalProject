//
//  CrustTableViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-15.
//

import UIKit

class CrustTableViewController: UITableViewController {
    
    var pizza: Pizza?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PizzaDataConfiguration.pizzaCrust.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrustCell", for: indexPath)

        cell.textLabel?.text = PizzaDataConfiguration.pizzaCrust[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPizzaCrust" {
            let destination = segue.destination as! CustomizePizzaController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.pizza = self.pizza
                destination.pizza?.setCrust(crust:PizzaDataConfiguration.pizzaCrust[indexPath.row])
                destination.displayMode = .new
            }
        }
    }

}
