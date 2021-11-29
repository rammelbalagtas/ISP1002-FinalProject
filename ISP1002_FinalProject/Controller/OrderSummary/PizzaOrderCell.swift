//
//  OrderSummaryCell.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-28.
//

import UIKit

protocol OrderSummary {
    func edit(indexPath: IndexPath)
    func remove(indexPath: IndexPath)
}

class PizzaOrderCell: UITableViewCell {
    
    var indexPath: IndexPath!
    var delegate: OrderSummaryTableViewController?
    
    @IBOutlet var pizzaName: UILabel!
    @IBOutlet var pizzaTopping: UILabel!
    @IBOutlet var pizzaQuantity: UILabel!
    @IBOutlet var pizzaTotalPrice: UILabel!
    
    @IBAction func editOrder(_ sender: UIButton) {
        delegate?.edit(indexPath: indexPath)
    }
    
    @IBAction func removeOrder(_ sender: UIButton) {
        delegate?.remove(indexPath: indexPath)
    }

}
