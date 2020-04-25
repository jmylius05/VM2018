//
//  MyPostsApi.swift
//  VisitMe
//
//  Created by Jessica Mylius on 10/31/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import Foundation
import FirebaseDatabase
class MyPostsApi {
    var REF_MYPOSTS = Database.database().reference().child("myPosts")
}
