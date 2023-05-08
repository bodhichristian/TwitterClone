//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/8/23.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    
    private let service = TweetService()
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    func likeTweet() {
        service.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
}
