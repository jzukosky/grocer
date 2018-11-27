//
//  Purchase+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var rawDate: NSDate?
    @NSManaged public var rawPaid: NSObject?
    @NSManaged public var purchaseDescription: String?
    @NSManaged public var rawReceipt: NSData?
    @NSManaged public var rawSelected: NSObject?
    @NSManaged public var tax: Float
    @NSManaged public var title: String?
    @NSManaged public var rawItems: NSSet?
    @NSManaged public var rawPurchasees: NSSet?
    @NSManaged public var rawPurchaser: User?

}

// MARK: Generated accessors for rawItems
extension Purchase {

    @objc(addRawItemsObject:)
    @NSManaged public func addToRawItems(_ value: Item)

    @objc(removeRawItemsObject:)
    @NSManaged public func removeFromRawItems(_ value: Item)

    @objc(addRawItems:)
    @NSManaged public func addToRawItems(_ values: NSSet)

    @objc(removeRawItems:)
    @NSManaged public func removeFromRawItems(_ values: NSSet)

}

// MARK: Generated accessors for rawPurchasees
extension Purchase {

    @objc(addRawPurchaseesObject:)
    @NSManaged public func addToRawPurchasees(_ value: User)

    @objc(removeRawPurchaseesObject:)
    @NSManaged public func removeFromRawPurchasees(_ value: User)

    @objc(addRawPurchasees:)
    @NSManaged public func addToRawPurchasees(_ values: NSSet)

    @objc(removeRawPurchasees:)
    @NSManaged public func removeFromRawPurchasees(_ values: NSSet)

}
