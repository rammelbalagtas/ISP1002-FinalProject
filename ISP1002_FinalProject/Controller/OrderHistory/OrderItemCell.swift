//
//  OrderCell.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-28.
//

import UIKit

protocol OrderHistory {
    func edit(indexPath: IndexPath)
    func remove(indexPath: IndexPath)
}

class OrderItemCell: UITableViewCell {
    
    var indexPath: IndexPath!
    var delegate: OrderHistoryTableViewController?

    @IBOutlet var orderId: UILabel!
    @IBOutlet var orderTotal: UILabel!
    
    @IBAction func editOrder(_ sender: UIButton) {
        delegate?.edit(indexPath: indexPath)
    }
    
    @IBAction func cancelOrder(_ sender: UIButton) {
        delegate?.remove(indexPath: indexPath)
    }

}
