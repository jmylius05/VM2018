//
//  User.swift
//  VisitMe
//
//  Created by Jessica Mylius on 6/19/19.
//  Copyright © 2019 Jess Mundo. All rights reserved.
//

import Foundation
class User {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var id: String?
    var isFollowing: Bool?
    
}

extension User {
    static func transformUser(dict: [String: Any], key: String) -> User {
        let user = User()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageURL"] as? String
        user.username = dict["username"] as? String
        user.id = key
    
    return user
    }
}
