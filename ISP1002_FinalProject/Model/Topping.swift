//
//  Topping.swift
//  ISP1002_FinalProject
//
//  Created by Rammel on 2021-11-14.
//

import Foundation

class Topping: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(type, forKey: "type")
        coder.encode(name, forKey: "name")
        coder.encode(level, forKey: "level")
    }
    
    required init?(coder: NSCoder) {
        type = coder.decodeObject(forKey: "type") as! String
        name = coder.decodeObject(forKey: "name") as! String
        level = coder.decodeObject(forKey: "level") as! String
        super.init()
    }
    
    private(set) var type: String
    private(set) var name: String
    private(set) var level: String

    init(type: String, name: String, level: String) {
        self.type = type
        self.name = name
        self.level = level
    }
    
    func setLevel(level: String) {
        self.level = level
    }
    
}
