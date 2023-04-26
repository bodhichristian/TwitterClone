//
//  UserService.swift
//  TwitterClone
//
//  Created by christian on 4/26/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                print("Snapshot received.")
                guard let user = try? snapshot.data(as: User.self) else { return }
                print(user)
                print("DEBUG: Username is \(user.username)")
                print("DEBUG: Email is \(user.email)")
            }
    }
}
