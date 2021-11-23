//
//  ViewController.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-09.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildCustomSegue" {
            let destination = segue.destination as! SizeTableViewController
            destination.pizza = Pizza(name: "Build Your Own Pizza")
        }
    }

}

