//
//  HomeViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/26/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var posts: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    
    var loadingMoreView: InfiniteScrollActivityView?
    
    var count = 0
    
    var isMoreDataLoading = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        self.refresh(pullDown: true)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        tableView.reloadData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            print (PFUser.current())
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController, animated: true) {
            //
        }
    }
    @IBAction func onRealLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            print (PFUser.current())
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(loginViewController, animated: true) {
            //
        }
    }
    
    func refresh(pullDown: Bool) {
        //let predicate = NSPredicate(format: "likesCount > 100")
        
        var query = PFQuery(className: "Post")
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
            if let posts = posts {
                // do something with the array of object returned by the call
                if self.posts != nil {
                    self.posts!.append(contentsOf: posts)
                } else {
                    self.posts = posts
                }
                print ("the number of posts is \(posts.count)")
                let post = posts[0]
                
                print("Created at: \(post.createdAt)")
                self.loadingMoreView!.stopAnimating()
                self.isMoreDataLoading = false
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = self.posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = self.posts![indexPath.row]
        cell.instagramPost = post as! PFObject
        
        return cell
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        self.refresh(pullDown: true)
        refreshControl.endRefreshing()
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.refresh(pullDown: false)
                
            }
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! PhotoCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts![indexPath.row]
        let view = segue.destination as! DetailViewController
        view.instagramPost = post
        
    }
    
 

}
