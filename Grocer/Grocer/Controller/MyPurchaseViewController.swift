//
//  MyPurchaseViewController.swift
//  Grocer
//
//  Created by linChunbin on 12/4/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

class MyPurchaseViewController: UIViewController {
    
    var payment: Double?
    var myItems: [Item] = []
    var user: User?
    var purchase: Purchase?
    var itemCount : Int = 0
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let fetchedUsers = fetchUsers(){
            for tempUser in fetchedUsers{
                if tempUser.isEqual(user){
                    itemCount = 0
                    if let fetchedItems = tempUser.getItems(){
                        for item in fetchedItems {
                            if let purchase = purchase {
                                if item.getPurchase()?.isEqual(purchase) ?? false {
                                    itemCount = itemCount + 1
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if itemCount != myItems.count{

            if let user = user{
                for item in myItems{
                    item.addToUsers(user)
                }
                
                do{
                    let managedObjectContext = user.managedObjectContext
                    try managedObjectContext?.save()
                }catch{
                    print("there is an error during save data\(error)")
                    return
                }
            }
        }
        
        calculatePayment()
        
        // Do any additional setup after loading the view.
    }
    

    func calculatePayment(){
        var payment = 0.0
        
        
        for item in myItems{
            if let userCount = item.getUsers()?.count{
                payment += (item.price) / Double(userCount)
            }
        }
        priceLabel.text = "$ \(payment)"
    }
    
    func fetchUsers()->[User]?{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        var fetchedUsers: [User] = []
        do {
            fetchedUsers = try managedContext.fetch(fetchRequest)
        } catch {
            print("Error fetch user)")
        }
        return fetchedUsers
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
