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
}
