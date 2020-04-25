//
//  HeaderProfileCollectionReusableView.swift
//  VisitMe
//
//  Created by Jessica Mylius on 10/24/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import UIKit

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPostsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    var user: User? {
        didSet {
            updateView()
        }
    }
    func updateView() {
            self.nameLabel.text = user!.username
            if let photoUrlString = user!.profileImageUrl {
                let photoUrl = URL(string: photoUrlString)
            self.profileImage.sd_setImage(with: photoUrl)
            }
        
    }
        
}
