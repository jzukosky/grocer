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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let date1 = dateFormatter.date(from: "01/12/2018") ?? Date(timeIntervalSinceNow: 0)
        let date2 = dateFormatter.date(from: "11/08/2018") ?? Date(timeIntervalSinceNow: 0)
        let date3 = dateFormatter.date(from: "11/07/2018") ?? Date(timeIntervalSinceNow: 0)
        let date4 = dateFormatter.date(from: "11/19/2018") ?? Date(timeIntervalSinceNow: 0)

        
        if let user1 = user1, let user2 = user2 {
            let purchase1 = Purchase(date: date1, paid: [user1: true, user2: false], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "ActiveTestPurchase11")
            let purchase2 = Purchase(date: date2, paid: [user1: true, user2: false], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "ActiveTestPurchase22")
            let purchase3 = Purchase(date: date3, paid: [user1: true, user2: true], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "PastTestPurchase11")
            let purchase4 = Purchase(date: date4, paid: [user1: true, user2: true], purchaseDescription: nil, receipt: Data(), selected: [:], tax: 2.3, title: "PastTestPurchase222")
            purchases = [purchase1!, purchase2!, purchase3!, purchase4!]
        }
        
        for purchase in purchases {
            if (!isPurchaseActive(purchase: purchase)){
                pastPurchases.append(purchase)
            }
            else{
                activePurchases.append(purchase)
            }
            print(purchase.date)
            print(formatDate(date: purchase.date))
        }
        
        /* ------ Test Data ------ */
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

                populatePurchaseCell(purchase: purchase, cell: cell)
            }
        }
        else if(indexPath.section == 1){
            if let cell = cell as? PurchaseTableViewCell{
                let purchase = pastPurchases[indexPath.row]
                
                populatePurchaseCell(purchase: purchase, cell: cell)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "purchaseDetailSegue",
            let destination = segue.destination as? PurchaseDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            if (tableView.indexPathForSelectedRow?.section == 0){
                destination.purchase = activePurchases[row]
            }
            else if (tableView.indexPathForSelectedRow?.section == 1){
                destination.purchase = pastPurchases[row]
            }
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func populatePurchaseCell(purchase:Purchase, cell: PurchaseTableViewCell){
        
        cell.purchaseLabel.text = purchase.title
        
        if let receipt = purchase.receipt,
            let receiptImage = UIImage(data: receipt) {
            cell.purchaseImage.image = receiptImage
        } else {
            cell.purchaseImage.image = UIImage(named: "ProfileImage")
        }
    }
    

    func isPurchaseActive(purchase: Purchase) -> Bool {
        for paid in purchase.paid.values {
            if paid == false {
                return true
            }
        }
        return false
    }
    
    func formatDate(date: Date) -> String {
        let today = Date(timeIntervalSinceNow: 0)
        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
        let dayBeforeYesterday = Date(timeIntervalSinceNow: -60*60*24*2)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if date >= today {
            return "Future"
        } else if date >= yesterday {
            return "Today"
        } else if date >= dayBeforeYesterday {
            return "Yesterday"
        } else {
            return dateFormatter.string(from: date)
        }
    }
}
