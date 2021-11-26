//
//  ViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-09.
//

import UIKit

class HomeViewController: UIViewController {
    
    var cart: Cart!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildCustomSegue" {
            let destination = segue.destination as! SizeTableViewController
            destination.pizza = Pizza(name: "Build Your Own Pizza", price: 10.0)
        }
    }
    
    //unwind from customize pizza screen
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }

}

