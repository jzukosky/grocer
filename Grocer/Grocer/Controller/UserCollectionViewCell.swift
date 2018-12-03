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
    @IBOutlet weak var grayView: UIView!
    var user:User?
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.roundedImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
        grayView.backgroundColor = UIColor.gray
        grayView.alpha = 0.0
        grayView.layer.cornerRadius = 20
    }
}

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.init(red:0.56, green:0.84, blue:0.54, alpha:1.0).cgColor
    }
}
