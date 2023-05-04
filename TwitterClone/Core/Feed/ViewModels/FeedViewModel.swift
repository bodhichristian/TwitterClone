//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/2/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var feed = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets { tweets in
            self.feed = tweets
            
            for i in 0 ..< self.feed.count {
                let uid = self.feed[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.feed[i].user = user
                }
            }
        }
    }
}
