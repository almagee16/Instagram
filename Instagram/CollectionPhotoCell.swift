//
//  CollectionPhotoCell.swift
//  Instagram
//
//  Created by Alvin Magee on 6/29/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import ParseUI

class CollectionPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            print ("at least the post was set")
            self.photoImage.file = instagramPost["media"] as? PFFile
            self.photoImage.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
