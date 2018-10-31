//
//  Purchase+CoreDataClass.swift
//  Grocer
//
//  Created by linChunbin on 10/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject {

    convenience init?(context: NSManagedObjectContext = AppDelegate.main.persistentContainer.viewContext, date: NSDate, paid: [User : Bool], purchaseDescription: String?, receipt: NSData, selected: [User : Bool], tax: Float, title: String?) {
        
        let appDelegate = AppDelegate.main
        
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Purchase.entity(), insertInto: context)
        self.date = date
        self.paid = paid
        self.purchaseDescription = purchaseDescription
        self.receipt = receipt
        self.selected = selected
        self.tax = tax
        self.title = title
    }
}
