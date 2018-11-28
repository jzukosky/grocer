//
//  Item+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/28/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    convenience init?(name: String, price: Float) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            name != "" else {
                return nil
        }
        
        self.init(entity: Item.entity(), insertInto: managedContext)
        
        self.name = name
        self.price = price
    }
    
    func getName() -> String? {
        return name
    }
    
    func getPrice() -> Float? {
        return price
    }
    
    func getPurchase() -> Purchase? {
        return purchase
    }
    
    func getUsers() -> [User]? {
        return users?.allObjects as? [User]
    }
    
    func generateString() -> String {
        return "name: \(String(describing: name)), price: \(price)"
    }
}
