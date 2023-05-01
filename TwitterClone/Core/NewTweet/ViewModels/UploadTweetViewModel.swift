//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/1/23.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    let service = TweetService()
    
    func uploadTweet(withBody body: String) {
        service.uploadTweet(body: body) { success in
            if success {
                // Dismiss modal view
            } else {
                // Show error message
            }
        }
    }
}
