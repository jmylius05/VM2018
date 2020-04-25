//
//  Comment.swift
//  VisitMe
//
//  Created by Jessica Mylius on 7/11/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import Foundation
class Comment {
    var commentText: String?
    var uid: String?
}
extension Comment {
    static func transformComment(dict: [String: Any]) -> Comment {
        let comment = Comment()
        
        comment.commentText = dict["commentText"] as? String
        comment.uid = dict["uid"] as? String
        return comment
    }
}
