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
    
    var instagramPost: PFObject! {
        didSet {
            print (instagramPost)
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
