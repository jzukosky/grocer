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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func requestCameraButton(_ sender: UIButton) {
        
        let camera = AVCaptureDevice.authorizationStatus(for: .video)
       
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
                guard accessGranted == true else { return }
                self.presentCamera()
            })
         if camera != .authorized{
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
                } else {}
            })
        
        if photos != .authorized{
            let alert = UIAlertController(title: "We need your permisson", message: "Please go to settings to allow photo library permission", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    func presentPhoto(){
        
        print("Photo library success")
    }
    func presentCamera(){
        print("camera success")
        
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
