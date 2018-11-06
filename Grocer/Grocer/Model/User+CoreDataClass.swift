//
//  User+CoreDataClass.swift
//  Grocer
//
//  Created by linChunbin on 10/29/18.
//  Copyright © 2018 it4500. All rights reserved.
//
//

import UIKit
import CoreData

public class User: NSManagedObject {

    convenience init?(username: String, email:String?, information:String?, picture: Data?){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        self.init(entity: User.entity(), insertInto: context)
        self.username = username
        self.email = email
        self.information = information
        self.picture = picture
    }
}
