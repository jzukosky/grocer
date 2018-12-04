//
//  UserCollectionViewController.swift
//  Grocer
//
//  Created by Brendan Krekeler on 11/15/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "userCell"

class UserCollectionViewController: UICollectionViewController {
    
    //let refreshControl = UIRefreshControl()
    @IBOutlet var usersCollectionView: UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    var users = [User]()
    var defaultImage = UIImage(named: "ProfileImage")
    
    var currentlyEditing = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //users.append(User(username: "okrek", email: "hi@fake.com", information: "does it matter", picture: nil)!)
        //users.append(User(username: "brendan", email: "fake@hi.com", information: "it does matter", picture: UIImage(named: "jonahiscool")?.pngData())!)
        

        let numberOfCells = CGFloat(2)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 30
            flowLayout.minimumLineSpacing = 30
            flowLayout.sectionInset.left = 30
            flowLayout.sectionInset.right = 30
            flowLayout.sectionInset.top = 30
            let horizontalSpacing = flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.right*2
            let cellWidth = (view.frame.width - (numberOfCells-1)*horizontalSpacing)/numberOfCells
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
        // Do any additional setup after loading the view.
        
        //collectionView.refreshControl = refreshControl
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserCollectionViewCell
        
        if currentlyEditing {
            cell.grayView.alpha = 0.5
            cell.deleteButtonBackgroundView.backgroundColor = UIColor.blue
        } else {
            cell.grayView.alpha = 0.0
        }

        cell.user = users[indexPath.row]
        
        if let image = users[indexPath.row].picture {
            cell.userImage?.image = UIImage(data: image, scale: 1.0)
        } else {
            cell.userImage?.image = defaultImage
        }
        
        // Configure the cell
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPurchases",
            let destination = segue.destination as? PurchasesTableViewController,
            let collectionView = self.collectionView,
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: indexPath) as?  UserCollectionViewCell{
            destination.purchaser = cell.user
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentlyEditing {
            performSegue(withIdentifier: "editUser", sender: self)
        } else {
            performSegue(withIdentifier: "showPurchases", sender: self)
        }
    }
    
    
    @IBAction func editUser(_ sender: Any) {
        currentlyEditing = !currentlyEditing
        if !currentlyEditing {
            editButton.title = "Edit"
            addBarButtonItem.isEnabled = true
        } else {
            editButton.title = "Done"
            addBarButtonItem.isEnabled = false
        }
        collectionView.reloadData()

    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        
//        addBarButtonItem.isEnabled = !editing
//    }

    override func viewWillAppear(_ animated: Bool) {
        fetchUsers()
        self.collectionView.reloadData()
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
            collectionView.reloadData()
        } catch {
            presentMessage(message: "An error occurred fetching: \(error)")
        }
        users.removeAll()
        users = fetchedUsers
    }

    func presentMessage(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
