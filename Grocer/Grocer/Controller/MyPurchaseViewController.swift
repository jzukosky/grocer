//
//  MyPurchaseViewController.swift
//  Grocer
//
//  Created by linChunbin on 12/4/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class MyPurchaseViewController: UIViewController {
    
    var myItems: [Item] = []
    var user: User?
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user{
            for item in myItems{
                print(item.getName())
                print(item.getPrice())
                print(user.getUsername())
                item.addToUsers(user)
            }
            
            do{
                let managedObjectContext = user.managedObjectContext
                try managedObjectContext?.save()
            }catch{
                print("there is an error during save data\(error)")
                return
            }
            
            print("Items saved to user")
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    func calculatePayment(){
        
        
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
