//
//  OrderHistoryTableView.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-15.
//

import UIKit

class OrderHistoryTableViewController: UITableViewController {
    
    let orderItemCellIdentifier = "OrderItemCell"
    var orders: OrderList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.orderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: orderItemCellIdentifier, for: indexPath) as? OrderItemCell else {
            fatalError("Unable to dequeue OrderItemCell")}
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.orderId.text = "Order ID: \(String(orders.orderList[indexPath.row].orderId))"
        cell.orderTotal.text = String(orders.orderList[indexPath.row].total)
        return cell
    }

}

extension OrderHistoryTableViewController: OrderHistory {
    func edit(row: Int) {
        //
    }
    func remove(row: Int) {
        //
    }
}
