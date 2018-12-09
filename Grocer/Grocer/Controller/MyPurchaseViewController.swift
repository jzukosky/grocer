//
//  MyPurchaseViewController.swift
//  Grocer
//
//  Created by linChunbin on 12/4/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class MyPurchaseViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var payment: Double = 0.0
    var myItems: [Item] = []
    var user: User?
    var purchase: Purchase?
    var itemCount : Int = 0
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
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
        
        var currentSelectedUser: Set<User> = []
        if let items = purchase?.getItems() {
            for item in items {
                if let users = item.getUsers() {
                    for user in users {
                        currentSelectedUser.insert(user)
                    }
                }
            }
        }

        if let recipientsCount = purchase?.getRecipients()?.count {
            if (recipientsCount + 1) != currentSelectedUser.count {
                confirmButton.isEnabled = false
                sendEmailButton.isEnabled = false
            }
        }
        
        if let payments = user?.getPayments() {
            for payment in payments {
                if (payment.getPurchase()?.isEqual(purchase))! {
                    confirmButton.isEnabled = false
                    sendEmailButton.isEnabled = false
                }
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func calculatePayment(){
        payment = 0.0
        
        
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
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        var users = fetchUsers()
        var emails: [String] = []
        for user in users!{
            emails.append(user.getEmail()!)
        }
        mailComposerVC.setToRecipients(emails)
        mailComposerVC.setSubject("Pay your stuff")
        mailComposerVC.setMessageBody("Please pay the amount: $\(payment)", isHTML: false)
        
        return mailComposerVC
    }
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmPaymentTapped(_ sender: Any) {

        let tempPayment = Payment(date: Date(timeIntervalSinceNow: 0), amount: payment)
        if let user = user, let tempPayment = tempPayment {
            tempPayment.user = user
            tempPayment.purchase = purchase
        }
        
        if let tempPayment = tempPayment {
            do {
                let managedObjectContext = tempPayment.managedObjectContext
                try managedObjectContext?.save()
            } catch {
                print("unable to save")
                return
            }
        }
        
        _ = navigationController?.popToRootViewController(animated: true)

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
