//
//  HomeTableViewCell.swift
//  VisitMe
//
//  Created by Jessica Mylius on 6/4/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {


    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var likeCountButton: UIButton!
    
    @IBOutlet weak var captionLabel: UILabel!
    
   
    var homeVC: HomeViewController?
    var post: Post? {
        didSet {
            updateView()
        }
    }
    
    var user: User? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateView() {
        captionLabel.text = post?.caption
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
        }
        
        
            self.updateLike(post: self.post!)
            
        }
    
    
    func updateLike(post: Post) {
        let imageName = post.likes == nil || !post.isLiked! ? "heartOutline" : "heartSelected"
        likeImageView.image = UIImage(named: imageName)
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountButton.setTitle("\(count) likes", for: UIControl.State.normal)
        } else {
            likeCountButton.setTitle("Be the first like this", for: UIControl.State.normal)
        }
        
    }
    
    func setupUserInfo() {
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImageUrl {
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "profilePhotoGoogle"))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        captionLabel.text = ""
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.commentImageView_TouchUpInside))
        commentImageView.addGestureRecognizer(tapGesture)
        commentImageView.isUserInteractionEnabled = true
        
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(self.likeImageView_TouchUpInside))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func likeImageView_TouchUpInside() {
        Api.Post.incrementLikes(postId: post!.id!, onSuccess: { (post) in
            self.updateLike(post: post)
            self.post?.likes = post.likes
            self.post?.isLiked = post.isLiked
            self.post?.likeCount = post.likeCount
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
        //incrementLikes(forRef: postRef)
    }
    
    @objc func commentImageView_TouchUpInside() {
        print("commentImageView_TouchUpInside")
        if let id = post?.id {
            homeVC?.performSegue(withIdentifier: "CommentSegue", sender: id)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("11111")
        profileImageView.image = UIImage(named: "profilePhotoGoogle")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}


