//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/8/23.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    
    private let service = TweetService()
    let tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    func likeTweet() {
        service.likeTweet(tweet)
    }
}
