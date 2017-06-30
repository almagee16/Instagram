//
//  DetailViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/27/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import ParseUI

class DetailViewController: UIViewController {

    
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var detailedImage: PFImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            if captionLabel == nil {
                return
            } else {
                captionLabel.text = instagramPost["caption"] as! String
                
                if let date = instagramPost.createdAt {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .short
                    let dateString = dateFormatter.string(from: date)
                    print ("The date string is \(dateString)")
                    print ("why isn't this thing working")
                    timeStampLabel.text = dateString
                    
                }
                self.detailedImage.file = instagramPost["media"] as? PFFile
                
            }

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let author = instagramPost["author"] as! PFUser
        let username = author.username as! String
        
        usernameButton.setTitle(username, for: .normal)

        if captionLabel == nil {
            
        } else {
            captionLabel.text = instagramPost["caption"] as! String
            
        }
        
        if timeStampLabel == nil {
            
        } else {
            if let date = instagramPost.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                let dateString = dateFormatter.string(from: date)
                print ("The date string is \(dateString)")
                print ("why isn't this thing working")
                timeStampLabel.text = dateString
                
            }
        }
        
        
        if detailedImage == nil {
            
        } else {
            self.detailedImage.file = instagramPost["media"] as? PFFile
        }
    }

    @IBAction func onProfileButton(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! UserViewController
        let user = instagramPost["author"] as! PFUser
        destination.user = user
    }
 

}
