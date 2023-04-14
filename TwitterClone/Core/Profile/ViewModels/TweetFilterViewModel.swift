//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/14/23.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets, replies, media, likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .media: return "Media"
        case .likes: return "Likes"
        }
    }
}
