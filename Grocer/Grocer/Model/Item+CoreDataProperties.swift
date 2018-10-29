//
//  Item+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 10/25/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userIds: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var itemToPurchase: Purchase?
    @NSManaged public var itemToUser: User?

}
