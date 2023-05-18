//
//  Tweet.swift
//  TwitterClone
//
//  Created by christian on 5/4/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    let body: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false // Must be optional to decode properly

    // Example tweet for previews
    static let example = Tweet(
        body: "This is a test tweet",
        timestamp: Timestamp(),
        uid: "RandomUIDLOL",
        likes: 0,
        user: User.example
    )
}
