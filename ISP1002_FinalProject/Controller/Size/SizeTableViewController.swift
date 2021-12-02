//
//  SizeTableViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-15.
//

import UIKit

class SizeTableViewController: UITableViewController {
    
    var pizza: Pizza?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PizzaDataConfiguration.pizzaSize.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeCell", for: indexPath)
        cell.textLabel?.text = PizzaDataConfiguration.pizzaSize[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPizzaSize" {
            let destination = segue.destination as! CrustTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.pizza = self.pizza
                destination.pizza?.setSize(size: PizzaDataConfiguration.pizzaSize[indexPath.row])
            }
        }
    }

}
