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
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()}))
                
                if let error = error {
                    print("DEBUG: Error fetching tweets with error: \(error.localizedDescription)")
                }
            }
    }
    
    
}

// MARK: Likes
extension TweetService {
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
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetID).getDocument { snapshot, error in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetID = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikesReference = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetID)
            .updateData(["likes" : tweet.likes - 1]) { _ in
                userLikesReference.document(tweetID).delete { _ in
                    completion()
                }
            }
        
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { doc in
                    let tweetID = doc.documentID
                    
                    Firestore.firestore().collection("tweets")
                        .document(tweetID)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                            tweets.append(tweet)
                            
                            completion(tweets)
                        }
                }
            }
    }
}
