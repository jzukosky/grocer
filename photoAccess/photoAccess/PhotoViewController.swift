//
//  PhotoViewController.swift
//  photoAccess
//
//  Created by Roger Kiew on 11/1/18.
//  Copyright © 2018 Roger Kiew. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestCameraButton(_ sender: UIButton) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.presentCamera()
        })
        let camera = AVCaptureDevice.authorizationStatus(for: .video)
        
        if camera == .denied{
            let alert = UIAlertController(title: "We need your permisson", message: "Please go to settings to allow camera permission", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func requestPhotoLibraryButton(_ sender: UIButton) {
        let photos = PHPhotoLibrary.authorizationStatus()
 
        PHPhotoLibrary.requestAuthorization({status in
            if status == .authorized{
                self.presentPhoto()
            } else {
                let alert = UIAlertController(title: "We need your permisson", message: "Please go to settings to allow photo library permission", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        })
    }
    func presentPhoto(){
        
        print("Photo library success")
        
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary;
                self.imagePicker.allowsEditing = false
                
                self.present(self.imagePicker, animated: true, completion: nil)
            }}
 
      /*  if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }*/
        }
    func presentCamera(){
        print("camera success")
        
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
            print("select inside")
        })
        print("select")
        imageView.image = image
        
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
