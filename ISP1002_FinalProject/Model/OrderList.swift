//
//  OrderList.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-25.
//

import Foundation

class OrderList {
    
    // URL for extracting the archived data
    let orderListURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("ordertest.archive")
    }()
    
    private(set) var orderList = [Order]()
    
    init() {
        // extract data from archive
        do {
            let data = try Data(contentsOf: orderListURL)
            orderList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Order]
        } catch let err {
            print(err.localizedDescription) //will print an error message when running app for the first time
        }
    }
    
    func addOrder(order: Order) {
        orderList.append(order)
    }
    
    func removeOrder(index: Int){
        orderList.remove(at: index)
    }
    
    // Update list of orders in archive
    func saveList(){
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: orderList, requiringSecureCoding: false)
            try data.write(to: orderListURL)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
    
}
