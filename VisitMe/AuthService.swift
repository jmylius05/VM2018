//
//  AuthService.swift
//  VisitMe
//
//  Created by Jessica Mylius on 12/6/18.
//  Copyright © 2018 Jess Mundo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class AuthService {
    
   // static keyword = created once
    
   
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
    if error != nil {
        onError(error!.localizedDescription)
    return
    }
    onSuccess()
    })
}
    static func signUp(username: String, fullName: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user , error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = user?.user.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_Image").child(uid!)
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            return
                        }else {
                            let profileImageUrl = url!.absoluteString
                            setUserInformation(profileImageURL: profileImageUrl, username: username, email: email, uid: uid!, onSuccess: onSuccess)
                        }
                })
            
        })
    }
)}
        static func setUserInformation(profileImageURL: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
            newUserReference.setValue(["username": username, "username_lowercaser": username.lowercased(), "email": email, "profileImageURL": profileImageURL])
        onSuccess()
    }
    static func logout(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void){
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let logoutError {
           onError(logoutError.localizedDescription)
        }
        
        
        
    }
    }

