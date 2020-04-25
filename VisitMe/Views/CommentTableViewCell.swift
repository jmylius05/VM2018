//
//  CommentTableViewCell.swift
//  VisitMe
//
//  Created by Jessica Mylius on 6/25/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Comment? {
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
        commentLabel.text = comment?.commentText
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
        commentLabel.text = ""
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "profilePhotoGoogle")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
