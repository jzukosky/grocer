//
//  UsersViewController.swift
//  Grocer
//
//  Created by Brendan Krekeler on 10/31/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userImageView: UIImageView!
    
    var defaultUser = UIImageView(image: <#T##UIImage?#>)

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath)
        
        let image = defaultUser
        
        cell.backgroundView = userImageView.
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
