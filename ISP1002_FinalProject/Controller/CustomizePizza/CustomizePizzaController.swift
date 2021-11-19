//
//  CustomizePizzaController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-12.
//

import UIKit

class CustomizePizzaController: UITableViewController {
    
    let toppingListCellIdentifier = "ToppingListCell"
    var sauceList = [Sauce]()
    var meatList = [Meat]()
    var vegetableList = [Vegetable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dummy Data
        self.sauceList.append(Sauce(name: "Sauce 1", level: "Normal"))
        self.sauceList.append(Sauce(name: "Sauce 2", level: "Extra"))
//        self.sauceList.append(Sauce(name: "Sauce 3", level: "level"))
//        self.sauceList.append(Sauce(name: "Sauce 4", level: "level"))
//        self.sauceList.append(Sauce(name: "Sauce 5", level: "level"))
        
        self.meatList.append(Meat(name: "Meat 1", level: "Normal"))
        self.meatList.append(Meat(name: "Meat 2", level: "Extra"))
//        self.meatList.append(Meat(name: "Meat 3", level: "level"))
//        self.meatList.append(Meat(name: "Meat 4", level: "level"))
//        self.meatList.append(Meat(name: "Meat 5", level: "level"))
        
        self.vegetableList.append(Vegetable(name: "Veg 1", level: "Normal"))
        self.vegetableList.append(Vegetable(name: "Veg 2", level: "Extra"))
//        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
//        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
//        self.vegetableList.append(Vegetable(name: "Veg 1", level: "level"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

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
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let sectionButton = UIButton()
//        sectionButton.setTitle(String("Sauce"),
//                               for: .normal)
//        sectionButton.contentHorizontalAlignment = .leading
//        sectionButton.backgroundColor = .systemBlue
//        sectionButton.tag = section
////        sectionButton.addTarget(self,
////                                action: #selector(self.hideSection(sender:)),
////                                for: .touchUpInside)
//
//        return sectionButton
//    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
