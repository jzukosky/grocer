//
//  PurchaseDetailViewController.swift
//  Grocer
//
//  Created by linChunbin on 11/8/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class PurchaseDetailViewController: UIViewController {
    var purchase:Purchase?

    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var purchaseImage: UIImageView!
    override func viewDidLoad() {
        if let receipt = purchase?.receipt,
            let receiptImage = UIImage(data:receipt){
            purchaseImage.image = receiptImage
        }
        purchaseLabel.text = purchase?.title
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
