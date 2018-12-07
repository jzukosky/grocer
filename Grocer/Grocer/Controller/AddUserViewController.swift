//
//  AddUserViewController.swift
//  Grocer
//
//  Created by Brendan Krekeler on 11/27/18.
//  Copyright © 2018 it4500. All rights reserved.
//

import UIKit
import CoreData

class AddUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var informationTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var newUser: User?
    var existingUser: User?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.title = "Add User"
        if let existingUser = existingUser
        {
            self.title = "Edit User"
            userNameTextField.text = existingUser.username
            informationTextField.text = existingUser.information
            emailTextField.text = existingUser.email
            //need to fix image constraints
            if let image = existingUser.picture {
                userPictureImageView.image = UIImage(data: image)
            }
       
        }

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func chooseUserPictureButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add a new photo", message: "How do you want to upload the picture?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "From camra", style: .default, handler: { action in
            self.takePhotoWithCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "From photo library", style: .default, handler: { action in
            self.getPhotoFromLibrary()
        }))
        self.present(alert, animated: true)
    }
    
    func takePhotoWithCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            let alertController = UIAlertController(title: "No Camera", message: "The device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getPhotoFromLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let username = userNameTextField.text else {
            return
        }
        var user: User?
        if existingUser != nil {
            user = existingUser
            user?.username = username
            user?.information = informationTextField.text
            user?.email = emailTextField.text
            user?.picture = userPictureImageView.image?.pngData()
            
        } else {
            user = User(username: username, email: emailTextField.text ?? "", information: informationTextField.text ?? "", picture: userPictureImageView.image?.pngData())
        }
        
        if let user = user {
            do {
                let managedObjectContext = user.managedObjectContext
                try managedObjectContext?.save()
            } catch {
                print("unable to save")
                return
            }
        } 
        
        _ = navigationController?.popViewController(animated: true)

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
