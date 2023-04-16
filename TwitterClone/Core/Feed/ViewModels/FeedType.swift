//
//  FeedType.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import Foundation

enum FeedType: Int, CaseIterable {
    case forYou, following
    
    var title: String {
        switch self {
        case .forYou: return "For You"
        case .following: return "Following"
        }
    }
}
