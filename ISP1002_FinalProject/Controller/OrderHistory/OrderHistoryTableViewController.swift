//
//  OrderHistoryTableView.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-15.
//

import UIKit

class OrderHistoryTableViewController: UITableViewController {
    
    let orderItemCellIdentifier = "OrderItemCell"
    let formatter = NumberFormatter()
    var orders: OrderList!
    var orderIndexPath: IndexPath?
    var previousRowCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        formatter.numberStyle = .currency
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.orderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: orderItemCellIdentifier, for: indexPath) as? OrderItemCell else {
            fatalError("Unable to dequeue OrderItemCell")}
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.orderId.text = "Order ID: \(String(orders.orderList[indexPath.row].orderId))"
        cell.orderTotal.text = formatter.string(from: orders.orderList[indexPath.row].total as NSNumber)
        return cell
    }
    
    // Pass the order ID when navigating to Order Summary Screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayOrderItemSegue" {
            let destination = segue.destination as! OrderSummaryTableViewController
            destination.order = orders.orderList[orderIndexPath!.row]
            destination.orderList = orders
        }
    }
    
    //this method is used to handle any additional actions whenever unwinding from any screen to the home screen
    @IBAction func unwindToOrderList( _ seg: UIStoryboardSegue) {
    }

}

// Delegate methods for View and Cancel buttons
extension OrderHistoryTableViewController: OrderHistory {
    func edit(indexPath: IndexPath) {
        orderIndexPath = indexPath
    }
    func remove(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Are you sure you want to cancel the order?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in self.onConfirmRemove(indexPath: indexPath)}))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func onConfirmRemove(indexPath: IndexPath) {
        if (!orders.orderList.isEmpty) {
            orders.removeOrder(index: indexPath.row)
            orders.saveList()
            tableView.deleteRows(at: [indexPath], with: .none)
            tableView.reloadData()
        }
    }
}
