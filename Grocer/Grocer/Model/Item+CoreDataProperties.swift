//
//  Item+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var rawUsers: NSOrderedSet?

}

// MARK: Generated accessors for rawUsers
extension Item {

    @objc(addRawUsersObject:)
    @NSManaged public func addToRawUsers(_ value: User)

    @objc(removeRawUsersObject:)
    @NSManaged public func removeFromRawUsers(_ value: User)

    @objc(addRawUsers:)
    @NSManaged public func addToRawUsers(_ values: NSSet)

    @objc(removeRawUsers:)
    @NSManaged public func removeFromRawUsers(_ values: NSSet)

}
