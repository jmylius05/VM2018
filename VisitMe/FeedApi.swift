//
//  FeedApi.swift
//  VisitMe
//
//  Created by Jessica Mylius on 1/5/20.
//  Copyright © 2020 Jess Mundo. All rights reserved.
//

import Foundation
import FirebaseDatabase
class FeedApi {
    var REF_FEED = Database.database().reference().child("feed")
    func observeFeed(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childAdded, with: {
            snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post)
                in
                completion(post)
            })
        })
    }
    
    func observeFeedRemoved(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childRemoved, with: {
         snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post) in
                completion(post)
            })
            
        })
    }
}
