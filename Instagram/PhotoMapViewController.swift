//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/27/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image: UIImage?
    
    let alertController = UIAlertController(title: "Image choice method", message: "Please choose a method to choose the image from", preferredStyle: .alert)
    
    let vc = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        vc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.allowsEditing = true
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            // handle response here.
            self.vc.sourceType = .camera
            self.present(self.vc, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            // handle response here.
            self.vc.sourceType = .photoLibrary
            self.present(self.vc, animated: true, completion: nil)
        }
        alertController.addAction(libraryAction)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        image = editedImage
        // Do something with the images (based on your use case)
        
        
        

        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "captionSegue", sender: self)
    }
    
    @IBAction func didTapCamera(_ sender: Any) {
        print ("WHAT IS GOING ON?!?!?!?!?!!")
        let vc = UIImagePickerController()
        vc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        }
        self.present(vc, animated:true, completion: nil)
    }
    
    @IBAction func didTapLibrary(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.allowsEditing = true

        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! CaptionViewController
        destination.image = self.image
    }
    

}
