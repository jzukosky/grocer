//
//  UserCollectionViewCell.swift
//  Grocer
//
//  Created by Brendan Krekeler on 11/15/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
    }
}
