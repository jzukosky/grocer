//
//  AddPurchaseViewController.swift
//  Grocer
//
//  Created by Jonah Zukosky on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

class AddPurchaseViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var receiptImageView: UIImageView!
    @IBOutlet weak var purchaserImageView: UIImageView!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    var allUsers = [User]()
    var participants = [User]()
    var nonParticipants = [User]()
    var purchaser: User?
    var items = [Item]()
    var receiptImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let purchaser = purchaser,
            let imageData = purchaser.picture,
            let image = UIImage(data: imageData, scale: 1.0) {
            purchaserImageView.image = image
        } else {
            purchaserImageView.image = UIImage(named: "ProfileImage")
        }
        
        if let receiptImage = receiptImage {
            //This should be set in the segue, should never fail
            receiptImageView.image = receiptImage
        }
    }
    
    @IBAction func handleTitleField(_ sender: Any) {
    }
    
    @IBAction func handleDateField(_ sender: Any) {
       
        
    }
    
    @IBAction func handleEditingBeginningDateField(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date.init()
       
        
        dateField.inputView = datePicker
       
        datePicker.addTarget(self, action: #selector(AddPurchaseViewController.datePickerValueChanged), for: .valueChanged)
    
        
        
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func handleSave(_ sender: Any) {
        //let user2 = User(username: "test recipient", email: "efg@mail.com", information: "efg", picture: nil)
        fetchUsers()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: dateField.text ?? "01-01-2018")
        
        if let purchaser = purchaser {
            let purchase = Purchase(title: titleField.text ?? "Untitled", purchaseDescription: descriptionField.text ?? "no description field", date: date ?? Date.init(timeIntervalSinceNow: 0), tax: 2.0, receipt: receiptImage?.pngData(), purchaser: purchaser);
            for user in allUsers{
                    purchase?.addToRecipients(user);
            }
            
            for item in items {
                purchase?.addToItems(item)
            }
            
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
        
        _ = navigationController?.popViewController(animated: true)
        

    }
    
    @IBAction func handleAddItem(_ sender: Any) {
        let alert = UIAlertController(title: "New Item", message: "Enter the title and price", preferredStyle: .alert)
        alert.addTextField { (titleField) in
            titleField.placeholder = "Title"
        }
        
        alert.addTextField { (priceField) in
            priceField.placeholder = "Price"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: {
                return
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            guard let title = alert.textFields?.first?.text,
            let priceString = alert.textFields?.last?.text,
            let price = Double(priceString) else {
                print("title or price failed")
                //self.present(alert, animated: true, completion: nil)
                let noAlert = UIAlertController(title: "Incorrect Information", message: nil, preferredStyle: .alert)
                noAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(noAlert, animated: true, completion: nil)
                return
            }
            
            if let newItem = Item(name: title, price: price) {
                self.items.append(newItem)
                print("appending")
                self.itemsTableView.reloadData()
                print("Items: \(self.items)")
            }
            
        }))
        
        self.present(alert,animated: true, completion: nil)
    }
    
}

extension AddPurchaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")!
        print("CELL FOR ROW AT")
        print(items)
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = String(items[indexPath.row].price)
        return cell
    }
    
}



extension AddPurchaseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return participants.count
        } else {
            return nonParticipants.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath)
        
        return cell
    }
    
    func presentMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchUsers(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        var fetchedUsers: [User] = []
        do {
            fetchedUsers = try managedContext.fetch(fetchRequest)
        } catch {
            presentMessage(message: "An error occurred fetching: \(error)")
        }
        allUsers.removeAll()
        allUsers = fetchedUsers
    }

    
}

