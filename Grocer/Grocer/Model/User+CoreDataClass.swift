//
//  User+CoreDataClass.swift
//  Grocer
//
//  Created by Qiwen Guo on 11/28/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

@objc(User)
public class User: NSManagedObject {
    var picture: Data? {
        get {
            return rawPicture as Data?
        }
        set {
            rawPicture = newValue as NSData?
        }
    }
    convenience init?(username: String, email: String, information: String, picture: Data?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            username != "" && email != "" else {
                return nil
        }
        
        self.init(entity: User.entity(), insertInto: managedContext)
        
        self.username = username
        self.email = email
        self.information = information
        self.picture = picture
    }
    
    func getUsername() -> String? {
        return username
    }
    
    func getEmail() -> String? {
        return email
    }
    
    func getInformation() -> String? {
        return information
    }
    
    func getPicture() -> Data? {
        return picture
    }
    
    func getRecipientPurchases() -> [User]? {
        return recipientPurchases?.allObjects as? [User]
    }
    
    func getPurchaserPurchases() -> [User]? {
        return purchaserPurchases?.allObjects as? [User]
    }
    
    func getPayments() -> [Payment]? {
        return payments?.allObjects as? [Payment]
    }
    
    func getItems() -> [Item]? {
        return items?.allObjects as? [Item]
    }
    
    func generateString() -> String {
        return "username: \(String(describing: username)), email: \(String(describing: email)), information: \(String(describing: information))"
    }
}
