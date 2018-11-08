//
//  Purchase+CoreDataProperties.swift
//  Grocer
//
//  Created by linChunbin on 10/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var date: Date
    @NSManaged public var paid: [User : Bool]
    @NSManaged public var purchaseDescription: String?
    @NSManaged public var receipt: Data?
    @NSManaged public var selected: [User : Bool]
    @NSManaged public var tax: Float
    @NSManaged public var title: String?
    @NSManaged public var items: NSSet?
    @NSManaged public var purchaser: User?
    @NSManaged public var purchasees: NSSet?

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

// MARK: Generated accessors for purchasees
extension Purchase {

    @objc(addPurchaseesObject:)
    @NSManaged public func addToPurchasees(_ value: User)

    @objc(removePurchaseesObject:)
    @NSManaged public func removeFromPurchasees(_ value: User)

    @objc(addPurchasees:)
    @NSManaged public func addToPurchasees(_ values: NSSet)

    @objc(removePurchasees:)
    @NSManaged public func removeFromPurchasees(_ values: NSSet)

}
