//
//  ViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-09.
//

import UIKit

class HomeViewController: UIViewController {
    
    var cart: Cart!
    var orderList: OrderList!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Display a message when cart is empty and do not proceed with segue
        if identifier == "ViewCartSegue" {
            if cart.pizzaList.isEmpty {
                let alert = UIAlertController(title: "", message: "Your cart is empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //This is the segue for navigating directly to "Customize Pizza Screen"
        if segue.identifier == "BuildCustomSegue" {
            let destination = segue.destination as! SizeTableViewController
            destination.pizza = Pizza(name: PizzaDataConfiguration.customPizzaName,
                                      description: nil,
                                      price: PizzaDataConfiguration.pizzaBasePrice,
                                      image: nil)
        //This is the segue for navigating directly to "Cart Screen"
        } else if segue.identifier == "ViewCartSegue" {
            let destination = segue.destination as! OrderSummaryTableViewController
            destination.cart = cart
            destination.orderList = orderList
        }
    }
    
    //this method is used to handle any additional actions whenever unwinding from any screen to the home screen
    @IBAction func unwindToHome( _ seg: UIStoryboardSegue) {
    }
}

