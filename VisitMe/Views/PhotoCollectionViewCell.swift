//
//  PhotoCollectionViewCell.swift
//  VisitMe
//
//  Created by Jessica Mylius on 11/6/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    var post: Post? {
        didSet {
            updateView()
        }
    }
    func updateView()  {
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            photo.sd_setImage(with: photoUrl)
        }
    }
}
