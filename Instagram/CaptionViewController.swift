//
//  CaptionViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/27/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//
import UIKit

class CaptionViewController: UIViewController {

    @IBOutlet weak var captionField: UITextField!
    
    var image: UIImage?
    
    @IBOutlet weak var displayedImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.displayedImage.image = image!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(_ sender: Any) {
        
        let caption = captionField.text
        
        Post.postUserImage(image: self.image, withCaption: caption) { (success: Bool, error: Error?) in
            if success {
                print ("success")
                
            } else {
                print (error?.localizedDescription)
            }
        }
        
        dismiss(animated: true) { 
            //
        }
        
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
