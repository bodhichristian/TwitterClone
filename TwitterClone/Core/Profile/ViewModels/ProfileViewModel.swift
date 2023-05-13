//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/5/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    private let service = TweetService()
    private let userService = UserService()
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
        case .tweets:
            return tweets
        case .replies:
            // Update to replies when ViewModel is updated
            return tweets
        case .media:
            // Update to media when ViewModel is updated
            return tweets
        case .likes:
            return likedTweets
        }
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else { return }
        
        service.fetchUserTweets(uid: uid) { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    func fetchLikedTweets() {
        guard let uid = user.id else { return }
        
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
    }
    
}
