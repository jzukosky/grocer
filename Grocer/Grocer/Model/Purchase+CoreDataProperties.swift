//
//  Purchase+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/28/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var purchaseDescription: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var rawReceipt: NSData?
    @NSManaged public var tax: Float
    @NSManaged public var title: String?
    @NSManaged public var items: NSSet?
    @NSManaged public var recipients: NSSet?
    @NSManaged public var purchaser: User?
    @NSManaged public var payments: NSSet?

}

// MARK: Generated accessors for items
extension Purchase {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for recipients
extension Purchase {

    @objc(addRecipientsObject:)
    @NSManaged public func addToRecipients(_ value: User)

    @objc(removeRecipientsObject:)
    @NSManaged public func removeFromRecipients(_ value: User)

    @objc(addRecipients:)
    @NSManaged public func addToRecipients(_ values: NSSet)

    @objc(removeRecipients:)
    @NSManaged public func removeFromRecipients(_ values: NSSet)

}

// MARK: Generated accessors for payments
extension Purchase {

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: Payment)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: Payment)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSSet)

}
