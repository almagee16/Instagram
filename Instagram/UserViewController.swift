//
//  UserViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/29/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Parse

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var count = 0
    var posts: [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // usernameLabel.text =

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
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
        query.whereKey("author", equalTo: PFUser.current()!)
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
