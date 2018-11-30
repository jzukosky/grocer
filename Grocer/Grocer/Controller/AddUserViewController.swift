//
//  AddUserViewController.swift
//  Grocer
//
//  Created by Brendan Krekeler on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var informationTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var newUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func chooseUserPictureButtonTapped(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true)
        {
            
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let username = userNameTextField.text else {
            return
        }
        var user: User?
        if let existingUser = newUser {
            user = existingUser
            user?.username = username
            user?.information = informationTextField.text
            user?.email = emailTextField.text
            
        } else {
            //user = User(username: username, email: emailTextField.text, information: informationTextField.text, picture: userPictureImageView)
            
        }
        do {
            try user?.managedObjectContext?.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save user")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            userPictureImageView.image = image
        }
        else
        {
            //error
        }
        self.dismiss(animated: true, completion: nil)
    }
}
