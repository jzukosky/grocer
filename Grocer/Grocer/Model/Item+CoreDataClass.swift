//
//  Item+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    var users: [User]? {
        return self.rawUsers?.array as? [User]
    }
    
    convenience internal init?(name: String, price: Float) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Item.entity(), insertInto: context)
        self.name = name
        self.price = price
    }
}
