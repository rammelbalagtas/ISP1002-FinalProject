//
//  ToppingListCell.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-14.
//

import Foundation
import UIKit

protocol CustomizePizza {
    func updateToppingLevel(newLevel: String, section: Int, row: Int)
}

class ToppingListCell: UITableViewCell {
    
    var delegate: CustomizePizza?
    var indexPath: IndexPath!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    
    @IBAction func increaseLevelAction(_ sender: UIButton) {
        if let currentIndex = PizzaDataConfiguration.toppingLevel.firstIndex(of: levelLabel.text!) {
            if currentIndex < PizzaDataConfiguration.toppingLevel.count - 1 {
                let newIndex = currentIndex + 1
                // update the UI
                levelLabel.text = PizzaDataConfiguration.toppingLevel[newIndex]
                // update the model
                delegate?.updateToppingLevel(newLevel: PizzaDataConfiguration.toppingLevel[newIndex], section: indexPath.section, row: indexPath.row)
            }
        }
    }
    
    @IBAction func decreaseLevelAction(_ sender: UIButton) {
        if let currentIndex = PizzaDataConfiguration.toppingLevel.firstIndex(of: levelLabel.text!) {
            if currentIndex != 0 {
                let newIndex = currentIndex - 1
                // update the UI
                levelLabel.text = PizzaDataConfiguration.toppingLevel[newIndex]
                // update the model
                delegate?.updateToppingLevel(newLevel: PizzaDataConfiguration.toppingLevel[newIndex], section: indexPath.section, row: indexPath.row)
            }
        }
    }
    
}
