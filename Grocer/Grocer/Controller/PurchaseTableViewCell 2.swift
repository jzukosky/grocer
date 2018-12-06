//
//  PurchaseTableViewCell.swift
//  Grocer
//
//  Created by linChunbin on 11/1/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var purchaseImage: UIImageView!
    
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var purchaseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            purchaseLabel.font = purchaseLabel.font.withSize(12)
            purchaseDateLabel.font = purchaseDateLabel.font.withSize(12)
        default:
            purchaseLabel.font = purchaseLabel.font.withSize(26)
            purchaseDateLabel.font = purchaseDateLabel.font.withSize(26)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
