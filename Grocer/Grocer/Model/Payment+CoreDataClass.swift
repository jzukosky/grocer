//
//  Payment+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Payment)
public class Payment: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(date: Date, amount: Double) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Payment.entity(), insertInto: managedContext)
        
        self.date = date
        self.amount = amount
    }
    
    func getDate() -> Date? {
        return date
    }
    
    func getAmount() -> Double? {
        return amount
    }
    
    func getPurchase() -> Purchase? {
        return purchase
    }
    
    func getUser() -> User? {
        return user
    }
    
    func generateString() -> String {
        return "date: \(String(describing: date)), amount: \(amount), user: \(String(describing: user?.generateString()))"
    }
}
