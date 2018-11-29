//
//  PurchasesTableViewController.swift
//  Grocer
//
//  Created by linChunbin on 11/1/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

class PurchasesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating  {

    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    var purchases: [Purchase] = []
    var pastPurchases:[Purchase] = []
    var activePurchases:[Purchase] = []
    var filteredPurchases = [Purchase]()
    var filteredActive = [Purchase]()
    var filteredPast = [Purchase]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* ------ Test Data: Delete before merge ------ */
        
//        let user1 = User(username: "abc", email: "abc@mail.com", information: "abc", picture: nil)
//        let user2 = User(username: "efg", email: "efg@mail.com", information: "efg", picture: nil)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//
//        let date1 = dateFormatter.date(from: "01/12/2018") ?? Date(timeIntervalSinceNow: 0)
//        let date2 = dateFormatter.date(from: "11/08/2018") ?? Date(timeIntervalSinceNow: 0)
//        let date3 = dateFormatter.date(from: "11/07/2018") ?? Date(timeIntervalSinceNow: 0)
//        let date4 = dateFormatter.date(from: "11/19/2018") ?? Date(timeIntervalSinceNow: 0)
//
//
//        if let user1 = user1, let user2 = user2 {
//            let purchase1 = Purchase(title: "Test1", purchaseDescription: "test1", date: date1, tax: 2.3, receipt: nil, purchaser: user1)
//            let purchase2 = Purchase(title: "Test2", purchaseDescription: "test1", date: date2, tax: 2.3, receipt: nil, purchaser: user2)
//            let purchase3 = Purchase(title: "Test3", purchaseDescription: "test1", date: date3, tax: 2.3, receipt: nil, purchaser: user2)
//            let purchase4 = Purchase(title: "Test4", purchaseDescription: "test1", date: date4, tax: 2.3, receipt: nil, purchaser: user1)
//
//            purchase1?.addToItems(Item(name: "test1", price: 3.0)!)
//            purchase2?.addToItems(Item(name: "test2", price: 4.0)!)
//            purchase2?.addToPayments(Payment(date: date2, amount: 4.0)!)
//
//            purchase3?.addToItems(Item(name: "test2", price: 5.0)!)
//            purchase3?.addToPayments(Payment(date: date2, amount: 4.0)!)
//
//            purchases = [purchase1!, purchase2!, purchase3!, purchase4!]
//        }
        /* ------ Test Data ------ */
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Purchase> = Purchase.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        do {
//            purchases = try managedContext.fetch(fetchRequest)
//            tableView.reloadData()
//            for purchase in purchases {
//                if let title = purchase.title {
//                    print(title)
//                }
//            }
//        } catch {
//            presentMessage(message: "An error occurred fetching: \(error)")
//        }
        
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        tableView.refreshControl = refreshControl

        fetchPurchases()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchPurchases()
        
        refreshControl.endRefreshing()
    }
    
    func fetchPurchases(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            purchases = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
            for purchase in purchases {
                if let title = purchase.title {
                    print(title)
                }
            }
            print(purchases.count)
            print("View will appear")
        } catch {
            presentMessage(message: "An error occurred fetching: \(error)")
        }
        
        
        pastPurchases.removeAll()
        activePurchases.removeAll()
        filteredPurchases.removeAll()
        filteredPast.removeAll()
        filteredActive.removeAll()
        
        filteredPurchases = purchases
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        /* ------ Test Data ------ */
        for purchase in filteredPurchases {
            if (!isPurchaseActive(purchase: purchase)){
                pastPurchases.append(purchase)
                filteredPast.append(purchase)
            }
            else{
                activePurchases.append(purchase)
                filteredActive.append(purchase)
            }
        }
        
        
    }

    @IBAction func testSaveData(_ sender: UIBarButtonItem) {
       
        let user1 = User(username: "abc", email: "abc@mail.com", information: "abc", picture: nil)
        let user2 = User(username: "efg", email: "efg@mail.com", information: "efg", picture: nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let date1 = dateFormatter.date(from: "01/12/2018") ?? Date(timeIntervalSinceNow: 0)

        
        
        if let user1 = user1, let user2 = user2 {
            let purchase = Purchase(title: "TestAdd", purchaseDescription: "test1", date: date1, tax: 2.3, receipt: nil, purchaser: user1)
            
            purchase?.addToItems(Item(name: "test1", price: 3.0)!)
            purchase?.addToRecipients(user2)
            
            if let purchase = purchase {
                do {
                    let managedObjectContext = purchase.managedObjectContext
                    try managedObjectContext?.save()
                } catch {
                    presentMessage(message: "An error occurred adding: \(error)")
                    return
                }
            }
        }

        
    }
    
    func presentMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return filteredActive.count
        case 1:
            return filteredPast.count
        default:
            return filteredPurchases.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath)
        if (indexPath.section == 0){
            if let cell = cell as? PurchaseTableViewCell{
                let purchase = filteredActive[indexPath.row]
                
                populatePurchaseCell(purchase: purchase, cell: cell)
            }
        }
        else if(indexPath.section == 1){
            if let cell = cell as? PurchaseTableViewCell{
                let purchase = filteredPast[indexPath.row]
                
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 90
        default:
            return 120
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "purchaseDetailSegue",
            let destination = segue.destination as? PurchaseDetailViewController,
            let row = tableView.indexPathForSelectedRow?.row {
            if (tableView.indexPathForSelectedRow?.section == 0){
                destination.purchase = filteredActive[row]
            }
            else if (tableView.indexPathForSelectedRow?.section == 1){
                destination.purchase = filteredPast[row]
            }
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func populatePurchaseCell(purchase:Purchase, cell: PurchaseTableViewCell){
        
        cell.purchaseLabel.text = purchase.title
        cell.purchaseDateLabel.text = formatDate(date: purchase.date ?? Date.init(timeIntervalSinceNow: 0))
        if let receipt = purchase.receipt,
            let receiptImage = UIImage(data: receipt) {
            cell.purchaseImage.image = receiptImage
        } else {
            cell.purchaseImage.image = UIImage(named: "ProfileImage")
        }
    }
    
    
    func isPurchaseActive(purchase: Purchase) -> Bool {
        var totalPayments: Float = 0.0;
        var totalPrice: Float = 0.0;
        if let payments = purchase.getPayments() {
            for payment in payments {
                totalPayments = payment.amount
            }
        }
        
        if let items = purchase.getItems() {
            for item in items {
                totalPrice += item.price
            }
        }
        
        return totalPayments != totalPrice
    }
    
    func formatDate(date: Date) -> String {
        let today = Date(timeIntervalSinceNow: 0)
        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
        let dayBeforeYesterday = Date(timeIntervalSinceNow: -60*60*24*2)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if date >= today {
            return "Something Went Wrong"
        } else if date >= yesterday {
            return "Today"
        } else if date >= dayBeforeYesterday {
            return "Yesterday"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredPurchases = purchases
            filteredActive = activePurchases
            filteredPast = pastPurchases
        } else {
            filteredActive = activePurchases.filter { $0.title!.lowercased().contains(searchController.searchBar.text!.lowercased()) }
            filteredPast = pastPurchases.filter { $0.title!.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
}
