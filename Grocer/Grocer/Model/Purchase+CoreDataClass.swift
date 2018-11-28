//
//  Purchase+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/28/18.
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
    
    convenience init?(title: String, purchaseDescription: String?, date: Date, tax: Float, receipt: Data?, purchaser: User) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            title != "" else {
                return nil
        }
        
        self.init(entity: Purchase.entity(), insertInto: managedContext)
        
        self.title = title
        self.purchaseDescription = purchaseDescription
        self.date = date
        self.tax = tax
        self.receipt = receipt
        self.purchaser = purchaser
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func getPurchaseDescription() -> String? {
        return purchaseDescription
    }
    
    func getTax() -> Float? {
        return tax
    }
    
    func getReceipt() -> Data? {
        return receipt
    }
    
    func getPurchaser() -> User? {
        return purchaser
    }
    
    func getRecipients() -> [User]? {
        return recipients?.allObjects as? [User]
    }
    
    func getPayments() -> [Payment]? {
        return payments?.allObjects as? [Payment]
    }
    
    func getItems() -> [Item]? {
        return items?.allObjects as? [Item]
    }
    
    func generateString() -> String {
        var purchaserInfo = ""
        if let purchaser = getPurchaser() {
            purchaserInfo = purchaser.generateString()
        }
        
        var recipientsInfo = ""
        if let recipients = getRecipients() {
            for recipient in recipients {
                recipientsInfo += recipient.generateString()
            }
        }
        
        var paymentInfo = ""
        if let payments = getPayments() {
            for payment in payments {
                paymentInfo += payment.generateString()
            }
        }
        
        
        return "title: \(String(describing: title)), purchaseDescription: \(String(describing: purchaseDescription)), date: \(String(describing: date)), tax: \(tax), purchaser: \(purchaserInfo), recipients: \(recipientsInfo), payments: \(paymentInfo)"
    }
}
