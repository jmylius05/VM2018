//
//  Api.swift
//  VisitMe
//
//  Created by Jessica Mylius on 7/30/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import Foundation
struct Api {
    static var User = UserApi()
    static var Post = PostApi()
    static var Comment = CommentApi()
    static var Post_Comment = PostCommentApi()
    static var MyPosts = MyPostsApi()
    static var Follow = FollowApi()
    static var Feed = FeedApi()
}
