//
//  TweetService.swift
//  TwitterClone
//
//  Created by christian on 5/1/23.
//

import Foundation
import Firebase

struct TweetService {
    
    func uploadTweet(body: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data: [String : Any] = ["uid": uid,
                                    "body": body,
                                    "likes": 0,
                                    "timestamp": Timestamp(date: Date())
        ]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { error in
                if let error = error {
                    completion(false)
                    print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                    return
                } else {
                    completion(true)
                }
            }
    }
    
    // Fetch tweets for FeedView
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets)
                
                if let error = error {
                    print("DEBUG: Error fetching tweets with error: \(error.localizedDescription)")
                }
            }
    }
    
    // Fetch tweets for ProfileView
    func fetchUserTweets(uid: String, completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)

            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                var tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
                
                if let error = error {
                    print("DEBUG: Error fetching tweets with error: \(error.localizedDescription)")
                }
            }
    }
    
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        
        let userLikesReference  = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweet.id ?? "")
            .updateData(["likes":  tweet.likes + 1]) { _ in
                userLikesReference.document(tweetID).setData([:]) { _ in
                    completion()
                    print("Did like tweet")
                }
            }
    }
}
