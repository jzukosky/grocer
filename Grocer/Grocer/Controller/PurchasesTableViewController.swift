//
//  PurchasesTableViewController.swift
//  Grocer
//
//  Created by linChunbin on 11/1/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class PurchasesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    var purchases: [Purchase] = []
    var pastPurchases:[Purchase] = []
    var activePurchases:[Purchase] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        /* ------ Test Data: Delete before merge ------ */
        
        let user1 = User(username: "abc", email: "abc@mail.com", information: "abc", picture: nil)
        let user2 = User(username: "efg", email: "efg@mail.com", information: "efg", picture: nil)
        
        if let user1 = user1, let user2 = user2 {
            let purchase1 = Purchase(date: Date(timeIntervalSinceNow: 0), paid: [user1: true, user2: false], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "ActiveTestPurchase11")
            let purchase2 = Purchase(date: Date(timeIntervalSinceNow: 0), paid: [user1: true, user2: false], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "ActiveTestPurchase22")
            let purchase3 = Purchase(date: Date(timeIntervalSinceNow: 0), paid: [user1: true, user2: true], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "PastTestPurchase11")
            let purchase4 = Purchase(date: Date(timeIntervalSinceNow: 0), paid: [user1: true, user2: true], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "PastTestPurchase222")
            purchases = [purchase1!, purchase2!, purchase3!, purchase4!]
        }
        
        for purchase in purchases {
            if (!isPurchaseActive(purchase: purchase)){
                pastPurchases.append(purchase)
            }
            else{
                activePurchases.append(purchase)
            }
        }
        
        /* ------ Test Data ------ */

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return activePurchases.count
        case 1:
            return pastPurchases.count
        default:
            return purchases.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath)
        if (indexPath.section == 0){
            if let cell = cell as? PurchaseTableViewCell{
                let purchase = activePurchases[indexPath.row]

                cell.purchaseLabel.text = purchase.title
                
                if let receipt = purchase.receipt,
                    let receiptImage = UIImage(data: receipt) {
                    cell.purchaseImage.image = receiptImage
                } else {
                    cell.purchaseImage.image = UIImage(named: "ProfileImage")
                }
            }
        }
        else if(indexPath.section == 1){
            if let cell = cell as? PurchaseTableViewCell{
                let purchase = pastPurchases[indexPath.row]
                
                cell.purchaseLabel.text = purchase.title
                
                if let receipt = purchase.receipt,
                    let receiptImage = UIImage(data: receipt) {
                    cell.purchaseImage.image = receiptImage
                } else {
                    cell.purchaseImage.image = UIImage(named: "ProfileImage")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Active Purchase"
        }
        if (section == 1){
            return "Past Purchase"
        }
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? SportsEventDetailViewController,
//            let row = sportsEventsTableView.indexPathForSelectedRow?.row {
//            destination.sportsEvent = sportsEvents[row]
//        }
//    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "activePurchases", for: indexPath)
//
//        let purchase = purchases[indexPath.row]
//
//        cell.textLabel?.text = purchase.title
//        // Configure the cell...
//
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func isPurchaseActive(purchase: Purchase) -> Bool {
        for paid in purchase.paid.values {
            if paid == false {
                return false
            }
        }
        return true
    }
}
