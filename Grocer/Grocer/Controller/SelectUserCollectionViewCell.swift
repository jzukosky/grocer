//
//  SelectUserCollectionViewCell.swift
//  Grocer
//
//  Created by linChunbin on 12/7/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class SelectUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    var user : User?

    override func awakeFromNib() {
        super.awakeFromNib()
        if let image = UIImage(named: "checkMark"){
            checkMarkImage.image = image
        }
        checkMarkImage.isHidden = true
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.backgroundColor = UIColor.red
                self.checkMarkImage.isHidden = false
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor.gray
                self.checkMarkImage.isHidden = true
            }
        }
    }
    
}

