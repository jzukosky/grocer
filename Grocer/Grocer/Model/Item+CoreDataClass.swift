//
//  Item+CoreDataClass.swift
//  Grocer
//
//  Created by linChunbin on 10/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    convenience internal init?(context: NSManagedObjectContext = AppDelegate.main.persistentContainer.viewContext, name: String, price: Float) {
        
        let appDelegate = AppDelegate.main
        
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Item.entity(), insertInto: context)
        self.name = name
        self.price = price
    }
}
