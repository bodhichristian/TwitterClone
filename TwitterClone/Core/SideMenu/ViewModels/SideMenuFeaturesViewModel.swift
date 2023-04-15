//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import Foundation

enum SideMenuFeaturesViewModel: Int, CaseIterable {
    case profile
    case topics
    case bookmarks
    case lists
    case twitterCircle

    var title: String {
        switch self {
        case .profile: return "Profile"
        case .topics: return "Topics"
        case .bookmarks: return "Bookmarks"
        case .lists: return "Lists"
        case .twitterCircle: return "Twitter Circle"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .topics: return "quote.bubble"
        case .bookmarks: return "bookmark"
        case .lists: return "list.bullet.rectangle.portrait"
        case .twitterCircle: return "person.2.circle"
        }
    }
}
