//
//  UserCollectionViewCell.swift
//  Grocer
//
//  Created by Brendan Krekeler on 11/15/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

typealias DeleteHandler = (User) -> Void
typealias Reloader = () -> Void

class UserCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    var user: User?
    var deletionHandler: DeleteHandler!
    var reload: Reloader!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.roundedImage()
        deleteButtonBackgroundView.circleImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
        grayView.backgroundColor = UIColor.lightGray
        grayView.alpha = 0.0
        grayView.layer.cornerRadius = 20
        deleteButtonBackgroundView.alpha = 1
    }
    
    func set(deleteHandler: @escaping DeleteHandler) {
        self.deletionHandler = deleteHandler
    }
    
    func set(reloadHandler: @escaping Reloader) {
        self.reload = reloadHandler
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        if let user = user {
            self.deletionHandler(user)
            self.reload()
        }
    }
}



protocol Roundable: class {
    var layer: CALayer { get }
    var clipsToBounds: Bool { get set }
    var bounds: CGRect { get set }
}

extension Roundable {
    func roundedImage() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.init(red:0.56, green:0.84, blue:0.54, alpha:1.0).cgColor
    }
    
    func circleImage() {
        self.layer.cornerRadius = self.bounds.width / 2.0
        self.layer.masksToBounds = true
    }
}

extension UIImageView: Roundable { }
extension UIVisualEffectView: Roundable { }
