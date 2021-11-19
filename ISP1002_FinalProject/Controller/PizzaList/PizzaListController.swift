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
        pizzaList.append(Pizza(name: "Pizza 1", description: "Description 1"))
        pizzaList.append(Pizza(name: "Pizza 2", description: "Description 2"))
        pizzaList.append(Pizza(name: "Pizza 3", description: "Description 3"))
        pizzaList.append(Pizza(name: "Pizza 4", description: "Description 4"))
        pizzaList.append(Pizza(name: "Pizza 5", description: "Description 5"))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        cell.descriptionLabel!.text = pizza.description
        return cell
    }

}
