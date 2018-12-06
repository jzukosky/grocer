//
//  EditUsersViewController.swift
//  Grocer
//
//  Created by Melissa Hollingshed on 11/5/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData


class EditUsersViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var informationTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    var existingUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let existingUser = existingUser {
            userNameTextField.text = existingUser.username
            informationTextField.text = existingUser.information
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseUserPictureButtonTapped(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPictureImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let username = userNameTextField.text else {
            return
        }
        var user: User?
        if let existingUser = existingUser {
            user = existingUser
            user?.username = username
            user?.information = informationTextField.text
            user?.email = emailTextField.text
        
        } else {
           // user = User(username: username, email: emailTextField.text, information: informationTextField.text, picture: userPictureImageView)
           
        }
        do {
            try user?.managedObjectContext?.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save user")
        }
        
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
