//
//  User+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 10/25/18.
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
    @NSManaged public var id: Int16
    @NSManaged public var information: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var username: String?
    @NSManaged public var pastPurchases: NSObject?
    @NSManaged public var userToPurchase: Purchase?
    @NSManaged public var userToItem: Item?

}
