//
//  HomeViewController.swift
//  VisitMe
//
//  Created by Jessica Mylius on 11/9/18.
//  Copyright © 2018 Jess Mundo. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    var posts = [Post]()
    var users = [User]()
        
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//  shrinks cell    tableView.estimatedRowHeight = 554
  //      tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        loadPosts()
        
        //        var post = Post(captionText: "test", photoUrlString: "url1")
        //        print(post.caption)
        //        print(post.photoUrl)
        
    }
    func loadPosts() {
        
        Api.Feed.observeFeed(withId: Api.User.CURRENT_USER!.uid)
        { (post) in
            guard let postId = post.uid else {
                                return
                            }
                         self.fetchUser(uid: postId, completed: {
                            self.posts.append(post)
                            self.tableView.reloadData()
                            })
        }
        
        Api.Feed.observeFeedRemoved(withId: Api.User.CURRENT_USER!.uid) { (post) in
            self.posts = self.posts.filter{ $0.id != post.id }
            self.users = self.users.filter { $0.id != post.uid}
            self.tableView.reloadData()

        }

    }


    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Api.User.observeUser(withId: uid, completion: {
            user in
            self.users.append(user)
            completed()
        })
        
    }
    
 
    @IBAction func logOut_TouchUpInside(_ sender: Any) {
        
        AuthService.logout(onSuccess: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CommentSegue" {
            let commentVC = segue.destination as! CommentViewController
            let postId = sender as! String
            commentVC.postId = postId
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        cell.homeVC = self
        return cell
    }
}
