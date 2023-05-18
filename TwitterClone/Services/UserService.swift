//
//  UserService.swift
//  TwitterClone
//
//  Created by christian on 4/26/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {

    // Fetches a specific user with the given UID
    func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                // Ensure a valid snapshot is received
                guard let snapshot = snapshot else { return }
                print("Snapshot received.")
                
                // Attempt to decode the snapshot data into a User object
                guard let user = try? snapshot.data(as: User.self) else { return }
                // Call the completion handler with the fetched user
                completion(user)
            }
    }
    
    // Fetches all users from the "users" collection
    func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                // Ensure valid documents are received
                guard let documents = snapshot?.documents else { return }
                // Convert the documents to an array of User objects
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                // Call the completion handler with the fetched users
                completion(users)
            }
    }
}






