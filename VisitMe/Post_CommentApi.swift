//
//  Post_CommentApi.swift
//  VisitMe
//
//  Created by Jessica Mylius on 7/31/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import Foundation
import FirebaseDatabase
class PostCommentApi {
    var REF_POST_COMMENTS = Database.database().reference().child("post-comments")
    
//    func observePostComments(withPostId id: String, completion: @escaping (Comment) -> Void) {
//        REF_COMMENTS.child(id).observeSingleEvent(of: .value, with: {
//            snapshot in
//            if let dict = snapshot.value as? [String: Any] {
//                let newComment = Comment.transformComment(dict: dict)
//                completion(newComment)
//            }
//        })
//    }
}
