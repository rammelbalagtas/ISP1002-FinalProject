//
//  OrderSummaryTableViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-28.
//

import UIKit

class OrderSummaryTableViewController: UITableViewController {
    
    @IBOutlet var pizzaOrderId: UILabel!
    @IBOutlet var pizzaOrderSubTotal: UILabel!
    @IBOutlet var pizzaOrderTax: UILabel!
    @IBOutlet var pizzaOrderTotal: UILabel!
    
    let pizzaOrderCellIdentifier = "OrderItemCell"
    var cart: Cart?
    var order: Order?
    var orderList: OrderList!
    var pizzaIndexPath: IndexPath?
    
    // actions
    @IBAction func actionCheckOut(_ sender: UIButton) {
        checkOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let cart = cart {
            pizzaOrderId.isHidden = true
            pizzaOrderSubTotal.text = String(cart.subTotal)
            pizzaOrderTax.text = String(cart.tax)
            pizzaOrderTotal.text = String(cart.total)
        } else if let order = order {
            pizzaOrderSubTotal.text = String(order.subTotal)
            pizzaOrderTax.text = String(order.tax)
            pizzaOrderTotal.text = String(order.total)
        } else {
            pizzaOrderSubTotal.text = "0.0"
            pizzaOrderTax.text = "0.0"
            pizzaOrderTotal.text = "0.0"
        }
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
        cell.pizzaTopping.text = "Topping \n Test"
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
    
    func checkOut() {
        let newOrder = Order(status: "In Progress",
                             pizzaList: cart!.pizzaList,
                             subTotal: cart!.subTotal,
                             tax: cart!.tax,
                             total: cart!.total)
        orderList.addOrder(order: newOrder)
        orderList.saveList()
        cart!.deleteList()
        let alert = UIAlertController(title: "",
                                      message: "Order \(String(newOrder.orderId)) is created",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { action in self.unwindSegue()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // for returning to home
    func unwindSegue () {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    //unwind from customize pizza screen after updating the order
    @IBAction func unwindToOrderSummary( _ seg: UIStoryboardSegue) {
        cart?.saveList()
        tableView.reloadRows(at: [pizzaIndexPath!], with: .none)
    }
    
}

extension OrderSummaryTableViewController: OrderSummary {
    func edit(indexPath: IndexPath) {
        pizzaIndexPath = indexPath
    }
    
    func remove(indexPath: IndexPath) {
        cart?.removePizza(index: indexPath.row)
        if let cart = cart {
            pizzaOrderId.isHidden = true
            pizzaOrderSubTotal.text = String(cart.subTotal)
            pizzaOrderTax.text = String(cart.tax)
            pizzaOrderTotal.text = String(cart.total)
        } else if let order = order {
            pizzaOrderSubTotal.text = String(order.subTotal)
            pizzaOrderTax.text = String(order.tax)
            pizzaOrderTotal.text = String(order.total)
        } else {
            pizzaOrderSubTotal.text = "0.0"
            pizzaOrderTax.text = "0.0"
            pizzaOrderTotal.text = "0.0"
        }
        cart?.saveList()
        tableView.deleteRows(at: [indexPath], with: .none)
    }
}
