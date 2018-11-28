//
//  User+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/28/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var information: String?
    @NSManaged public var rawPicture: NSData?
    @NSManaged public var username: String?
    @NSManaged public var purchaserPurchases: NSSet?
    @NSManaged public var recipientPurchases: NSSet?
    @NSManaged public var payments: NSSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for purchaserPurchases
extension User {

    @objc(addPurchaserPurchasesObject:)
    @NSManaged public func addToPurchaserPurchases(_ value: Purchase)

    @objc(removePurchaserPurchasesObject:)
    @NSManaged public func removeFromPurchaserPurchases(_ value: Purchase)

    @objc(addPurchaserPurchases:)
    @NSManaged public func addToPurchaserPurchases(_ values: NSSet)

    @objc(removePurchaserPurchases:)
    @NSManaged public func removeFromPurchaserPurchases(_ values: NSSet)

}

// MARK: Generated accessors for recipientPurchases
extension User {

    @objc(addRecipientPurchasesObject:)
    @NSManaged public func addToRecipientPurchases(_ value: Purchase)

    @objc(removeRecipientPurchasesObject:)
    @NSManaged public func removeFromRecipientPurchases(_ value: Purchase)

    @objc(addRecipientPurchases:)
    @NSManaged public func addToRecipientPurchases(_ values: NSSet)

    @objc(removeRecipientPurchases:)
    @NSManaged public func removeFromRecipientPurchases(_ values: NSSet)

}

// MARK: Generated accessors for payments
extension User {

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: Payment)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: Payment)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSSet)

}

// MARK: Generated accessors for items
extension User {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
