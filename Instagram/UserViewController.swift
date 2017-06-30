//
//  UserViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/29/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var profileImage: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var posts: [PFObject]?
    let alertController = UIAlertController(title: "Image choice method", message: "Please choose a method to choose the image from", preferredStyle: .alert)
    var image: UIImage?
    let vc = UIImagePickerController()
    var user: PFUser?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var loadingMoreView: InfiniteScrollActivityView?
    var count = 0
    var isMoreDataLoading = false

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if user == nil {
            user = PFUser.current()!
            
        } else {
            profilePictureButton.setTitle("", for: .normal)
        }
        
        let frame = CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        collectionView.addSubview(loadingMoreView!)
        
        let refreshControl = UIRefreshControl()
        self.refresh(pullDown: true)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)

        
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
        
        print (" the user is \(user!)")
        print (user!.value(forKey: "Profile_picture"))
        print ("okay after all that")
        let pictureFile = user!.value(forKey: "Profile_picture")
        self.profileImage.file = pictureFile as? PFFile
        self.profileImage.loadInBackground()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        profileImage.layer.cornerRadius = profileImage.frame.width * 0.5
        profileImage.layer.masksToBounds = true
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        flowLayout.itemSize = CGSize(width: 1/3*collectionView.frame.width - 1, height: 1/3*collectionView.frame.height - 1)
        
        
        usernameLabel.text = user!.username
        self.refresh(pullDown: true)
        collectionView.reloadData()
        print ("COLLECTION VIEW RELOADED IN VIEW DID LOAD")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(pullDown: Bool) {
        //let predicate = NSPredicate(format: "likesCount > 100")

        var query = PFQuery(className: "Post")
        query.whereKey("author", equalTo: user!)
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("_created_At")
        query.limit = 20
        
        if pullDown {
            self.count = 0
            self.posts = nil
        }
        query.skip = self.count
        self.count = self.count + 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            print ("The posts are \(posts)")
            if let posts = posts {
                // do something with the array of object returned by the call
                if self.posts != nil {
                    self.posts!.append(contentsOf: posts)
                } else {
                    self.posts = posts
                }
                print ("the number of posts is \(posts.count)")
                let post = posts[0]
                
                //self.loadingMoreView!.stopAnimating()
                //self.isMoreDataLoading = false
                self.collectionView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
        print ("the collection refresh just printed")
        collectionView.reloadData()
        print ("the data reloaded okay")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let posts = self.posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionPhotoCell", for: indexPath) as! CollectionPhotoCell
        let post = self.posts![indexPath.row]
        cell.instagramPost = post as! PFObject
        
        return cell
        
    }

    
    @IBAction func onProfileButton(_ sender: Any) {
//        let alertController = UIAlertController(title: "Image choice method", message: "Please choose a method to choose the image from", preferredStyle: .alert)
//        
//        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//                        // handle response here.
//        }
//        alertController.addAction(OKAction)
        if user == PFUser.current() {
            print ("it's getting here what the heck")
            present(alertController, animated: true) {
                
            }
        } else {
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = collectionView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - collectionView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && collectionView.isDragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                let frame = CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.refresh(pullDown: false)
                
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.image = editedImage
        let file = Post.getPFFileFromImage(image: self.image)
        
        
        PFUser.current()?.setValue(file, forKey: "Profile_picture")
        PFUser.current()?.saveInBackground(block: { (success: Bool, error: Error?) in
            if success {
                print ("success")
                
                let pictureFile = PFUser.current()?.value(forKey: "Profile_picture")
                self.profileImage.file = pictureFile as! PFFile
                self.profileImage.loadInBackground()
            } else {
                print (error?.localizedDescription)
            }
        })
        
        
        // Do something with the images (based on your use case)
        
        
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        self.refresh(pullDown: true)
        refreshControl.endRefreshing()
        
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! CollectionPhotoCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = posts![indexPath.row]
        let view = segue.destination as! DetailViewController
        view.instagramPost = post
    }
    

}
