//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/2/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    let service = TweetService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        service.fetchTweets()

    }
}
