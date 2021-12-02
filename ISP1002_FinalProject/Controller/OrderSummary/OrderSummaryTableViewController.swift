//
//  OrderSummaryTableViewController.swift
//  This is the table view controller for the order summary of either cart or existing active order
//
//  Created by Rammel on 2021-11-28.
//

import UIKit

class OrderSummaryTableViewController: UITableViewController {
    
    @IBOutlet var pizzaOrderId: UILabel!
    @IBOutlet var pizzaOrderSubTotal: UILabel!
    @IBOutlet var pizzaOrderTax: UILabel!
    @IBOutlet var pizzaOrderTotal: UILabel!
    
    @IBOutlet var btnCheckOutUpdate: UIButton!
    
    let pizzaOrderCellIdentifier = "OrderItemCell"
    var cart: Cart?
    var order: Order?
    var orderList: OrderList!
    var pizzaIndexPath: IndexPath?
    
    // actions
    @IBAction func actionCheckOut(_ sender: UIButton) { checkOut() }
    
    //Handler method when unwinding from customize pizza screen after updating the order
    @IBAction func unwindToOrderSummary( _ seg: UIStoryboardSegue) {
        tableView.reloadRows(at: [pizzaIndexPath!], with: .none)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let cart = cart {
            pizzaOrderId.isHidden = true
            pizzaOrderSubTotal.text = String(cart.subTotal)
            pizzaOrderTax.text = String(cart.tax)
            pizzaOrderTotal.text = String(cart.total)
        } else if let order = order {
            pizzaOrderId.text = "Order ID: " + String(order.orderId)
            pizzaOrderSubTotal.text = String(order.subTotal)
            pizzaOrderTax.text = String(order.tax)
            pizzaOrderTotal.text = String(order.total)
            btnCheckOutUpdate.setTitle("Update", for: .normal)
        } else {
            pizzaOrderSubTotal.text = "0.0"
            pizzaOrderTax.text = "0.0"
            pizzaOrderTotal.text = "0.0"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cart = cart {
            return cart.pizzaList.count
        } else if let order = order {
            return order.pizzaList.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: pizzaOrderCellIdentifier, for: indexPath) as? PizzaOrderCell else {
            fatalError("Unable to dequeue PizzaOrderCell")
        }
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let pizza: Pizza?
        if let cart = cart {
            pizza = cart.pizzaList[indexPath.row]
        } else if let order = order {
            pizza = order.pizzaList[indexPath.row]
        } else {
            pizza = nil
        }
        
        cell.pizzaQuantity.text = "Qty: \(String(pizza!.quantity))"
        cell.pizzaName.text = pizza!.name
        cell.pizzaTopping.text = "Topping \n Test" //temporary text
        let totalPrice = pizza!.price * Double(pizza!.quantity)
        cell.pizzaTotalPrice.text = String(totalPrice)
        return cell
    }
    
    // Define header for each topping table
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "Your Items:"
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditOrderSegue" {
            let destination = segue.destination as! CustomizePizzaController
            if let cart = cart {
                destination.displayMode = .edit_pizza_cart
                destination.pizza = cart.pizzaList[pizzaIndexPath!.row]
            } else if let order = order {
                destination.displayMode = .edit_pizza_order
                destination.pizza = order.pizzaList[pizzaIndexPath!.row]
            }
        }
    }
    
    // This method serves two functions depending on the scenario:
    // 1. Checkout - when checking out the items inside a cart
    // 2. Update - when updating an existing active order
    func checkOut() {
        var message = ""
        if let cart = cart {
            let newOrder = Order(status: "In Progress",
                                 pizzaList: cart.pizzaList,
                                 subTotal: cart.subTotal,
                                 tax: cart.tax,
                                 total: cart.total)
            orderList.addOrder(order: newOrder)
            orderList.saveList()
            cart.deleteList()
            message = "Order \(String(newOrder.orderId)) is created"
        } else if let order = order {
            orderList.saveList()
            message = "Order \(String(order.orderId)) is updated"
        }
        
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in self.performSegue(withIdentifier: "unwindToHome", sender: self)}))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// Contains delegated methods
extension OrderSummaryTableViewController: OrderSummary {
    func edit(indexPath: IndexPath) {
        pizzaIndexPath = indexPath // index will be used to pass the pizza object to customize pizza screen
    }
    
    func remove(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Are you sure you want to remove the item?",
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
        if let cart = cart {
            cart.removePizza(index: indexPath.row)
            if (!cart.pizzaList.isEmpty) {
                pizzaOrderSubTotal.text = String(cart.subTotal)
                pizzaOrderTax.text = String(cart.tax)
                pizzaOrderTotal.text = String(cart.total)
            } else {
                self.performSegue(withIdentifier: "unwindToHome", sender: self)
            }
        } else if let order = order {
            order.removePizza(index: indexPath.row)
            if (!order.pizzaList.isEmpty) {
                pizzaOrderSubTotal.text = String(order.subTotal)
                pizzaOrderTax.text = String(order.tax)
                pizzaOrderTotal.text = String(order.total)
                orderList.saveList()
            } else {
                self.performSegue(withIdentifier: "unwindToHome", sender: self)
            }
        }
        tableView.deleteRows(at: [indexPath], with: .none)
        tableView.reloadData()
    }
}
