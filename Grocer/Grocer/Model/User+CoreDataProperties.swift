//
//  User+CoreDataProperties.swift
//  Grocer
//
//  Created by linChunbin on 10/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchUserRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var information: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var username: String?
    @NSManaged public var pastPurchases: NSSet?

}

// MARK: Generated accessors for pastPurchases
extension User {

    @objc(addPastPurchasesObject:)
    @NSManaged public func addToPastPurchases(_ value: Purchase)

    @objc(removePastPurchasesObject:)
    @NSManaged public func removeFromPastPurchases(_ value: Purchase)

    @objc(addPastPurchases:)
    @NSManaged public func addToPastPurchases(_ values: NSSet)

    @objc(removePastPurchases:)
    @NSManaged public func removeFromPastPurchases(_ values: NSSet)

}
