//
//  User+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/27/18.
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
    @NSManaged public var rawPastPurchases: NSSet?

}

// MARK: Generated accessors for rawPastPurchases
extension User {

    @objc(addRawPastPurchasesObject:)
    @NSManaged public func addToRawPastPurchases(_ value: Purchase)

    @objc(removeRawPastPurchasesObject:)
    @NSManaged public func removeFromRawPastPurchases(_ value: Purchase)

    @objc(addRawPastPurchases:)
    @NSManaged public func addToRawPastPurchases(_ values: NSSet)

    @objc(removeRawPastPurchases:)
    @NSManaged public func removeFromRawPastPurchases(_ values: NSSet)

}
