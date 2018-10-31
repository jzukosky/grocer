//
//  AppDelegate.swift
//  Grocer
//
//  Created by Qiwen Guo on 10/22/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var main: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UIViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        // Override point for customization after application launch.
        
//        // Test the model: delete when implement UI
//        let user = User(username: "test", email: "testemail", information: "testinfo", picture: NSData())
//
//        let requestUser : NSFetchRequest<User> = User.fetchUserRequest()
//
//        do{
//            let users = try persistentContainer.viewContext.fetch(requestUser)
//            for user in users {
//                print(user.username)
//                print(user.email ?? "")
//            }
//
//        }catch{
//             print("Failed to fetch users")
//        }
//
//        let item = Item(name: "testItem", price: 2.0)
//
//        let requestItem : NSFetchRequest<Item> = Item.fetchItemRequest()
//
//        do {
//            let items = try persistentContainer.viewContext.fetch(requestItem)
//            for item in items {
//                print(item.name)
//                print(item.price)
//            }
//        } catch {
//            print("Failed to fetch items")
//        }
//
//        let purchase = Purchase(date: NSDate.init(timeIntervalSinceNow: 0), paid: [user! :true], purchaseDescription: nil, receipt: NSData(), selected: [user! :true], tax: 0.1, title: "test purchase")
//
//        let requestPurchase : NSFetchRequest<Purchase> = Purchase.fetchRequest()
//
//        do {
//            let purchases = try persistentContainer.viewContext.fetch(requestPurchase)
//            for purchase in purchases {
//                print(purchase.date)
//            }
//        } catch {
//            print("Fail to fetch purchases")
//        }
//
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Grocer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

