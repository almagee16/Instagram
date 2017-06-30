//
//  PhotoCell.swift
//  Instagram
//
//  Created by Alvin Magee on 6/27/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import ParseUI

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImage: PFImageView!
    @IBOutlet weak var profileImage: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            let date = instagramPost.createdAt
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date!)
            
            var captionText = ""
            captionText = captionText + dateString + "\n"
            let caption = instagramPost["caption"] as! String
            captionText = captionText + caption
            
            
            
            self.captionLabel.text = captionText
            let author = instagramPost["author"] as! PFUser
            
            print ("this is the author: \(author)")
            print ("this is the author's profile picture: \(author.value(forKey: "Profile_picture")))")
            
            
            
            self.usernameLabel.text = author.username!
            
            profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
            profileImage.layer.masksToBounds = true
            
            self.profileImage.file = author.value(forKey: "Profile_picture") as! PFFile
            self.profileImage.loadInBackground()
            
            
            
            self.photoImage.file = instagramPost["media"] as? PFFile
            self.photoImage.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
