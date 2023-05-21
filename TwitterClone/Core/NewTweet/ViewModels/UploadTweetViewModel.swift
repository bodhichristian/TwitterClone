//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by christian on 5/1/23.
//

import Foundation
import UIKit

class UploadTweetViewModel: ObservableObject {
    let service = TweetService()
    
    @Published var didUploadTweet = false
    
    func uploadTweet(withBody body: String, tweetImage: UIImage?) {
        service.uploadTweet(body: body) { success in
            if success {
                self.didUploadTweet = true
                print("Tweet successfully uploaded")
            } else {
                // Show error message
            }
        }
    }
}
