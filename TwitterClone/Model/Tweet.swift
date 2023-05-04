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
    
    static let example = Tweet(body: "This is a test tweet", timestamp: Timestamp(), uid: "RandomUIDLOL", likes: 0, user: User(username: "testUser", email: "test@test.test", name: "Test User", phoneNumber: "999-999-9999", profilePhotoUrl: "https://static.vecteezy.com/system/resources/previews/002/534/045/original/social-media-twitter-logo-blue-isolated-free-vector.jpg"))
}
