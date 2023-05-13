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
        // MARK: THIS IS A BANDAID
        // Commented portion of function is design, but current fetch bug prevents app from fully launching
        // Find and fix bug, and return to original function
        guard let uid = user.id else { return }
        

            service.fetchLikedTweets(forUid: uid) { tweets in
                self.likedTweets = tweets
                
                self.likedTweets = tweets
                
                let likedCount = tweets.count
                let tweetCount = self.tweets.count
                
                // Determine the maximum number of iterations based on the smaller array count
                let iterationCount = min(likedCount, tweetCount)
                
                for i in 0..<iterationCount {
                    let uid = tweets[i].uid
                    
                    self.userService.fetchUser(withUid: uid) { user in
                        self.tweets[i].user = user
                    }
            }
            //        guard let uid = user.id else { return }
            //
            //        service.fetchLikedTweets(forUid: uid) { tweets in
            //            self.likedTweets = tweets
            //
            //            for i in 0..<tweets.count {
            //                let uid = tweets[i].uid
            //
            //                self.userService.fetchUser(withUid: uid) { user in
            //                    self.tweets[i].user = user
            //                }
            //            }
            //        }
        }
    }
    
}
