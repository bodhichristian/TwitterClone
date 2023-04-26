//
//  UserService.swift
//  TwitterClone
//
//  Created by christian on 4/26/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                print("Snapshot received.")
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
}
