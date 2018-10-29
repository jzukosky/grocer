//
//  Purchase+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 10/25/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var receipt: NSData?
    @NSManaged public var purchaser: Int16
    @NSManaged public var purchasees: NSObject?
    @NSManaged public var items: NSObject?
    @NSManaged public var done: NSObject?
    @NSManaged public var paid: NSObject?
    @NSManaged public var tax: Float
    @NSManaged public var title: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var purchaseDescription: String?
    @NSManaged public var id: Int16
    @NSManaged public var purchaseToItem: Item?
    @NSManaged public var purchaseToUser: User?

}
