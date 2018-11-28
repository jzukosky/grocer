//
//  Purchase+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject {
    
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    var receipt: Data? {
        get {
            return rawReceipt as Data?
        }
        set {
            rawReceipt = newValue as NSData?
        }
    }
    
    var paid: [User : Bool] {
        get {
            return rawPaid as! [User : Bool] // ? how to convert nsobject to dictionary???
        }
        set {
            rawPaid = newValue as NSObject
        }
    }
    
    var selected: [User : Bool] {
        get {
            return rawSelected as! [User : Bool] // ? how to convert nsobject to dictionary???
        }
        set {
            rawSelected = newValue as NSObject
        }
    }
    
    var purchasees: [User]? {
        return self.rawPurchasees?.array as? [User]
    }
    
    var items: [Item]? {
        return self.rawItems?.array as? [Item]
    }
    
    var purchaser: User {
        return self.rawPurchaser!
    }
    
    convenience init?(date: Date, paid: [User : Bool], purchaseDescription: String?, receipt: Data, selected: [User : Bool], tax: Float, title: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
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
    
    convenience init?(date: Date, purchaseDescription: String?, receipt: Data, tax: Float, title: String?) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: Purchase.entity(), insertInto: context)
        self.date = date
        self.purchaseDescription = purchaseDescription
        self.receipt = receipt
        self.tax = tax
        self.title = title
    }
}
