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
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets { feed in
            self.feed = feed
        }
    }
}
