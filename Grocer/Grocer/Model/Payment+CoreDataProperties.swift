//
//  Payment+CoreDataProperties.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var purchase: Purchase?
    @NSManaged public var user: User?

}
