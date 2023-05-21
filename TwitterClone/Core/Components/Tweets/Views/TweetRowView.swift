//
//  TweetRowView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var viewModel: TweetRowViewModel
    
    init(tweet: Tweet) {
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Profile Image, user info, tweet
            HStack(alignment: .top, spacing: 12) {
                userProfilePhoto
                
                VStack(alignment: .leading, spacing: 4) {
                    header // User, @username, time, menu
                    
                    tweetContent // Tweet body, optional image
                    
                    tweetActions // Reply, retweet, like, analytics, share
                }
            }
            .padding(.horizontal)
            .padding(.top, 4)
            
            // Divider
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.secondary.opacity(0.3))
        }
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView(tweet: Tweet.example)
    }
}

extension TweetRowView {
    var userProfilePhoto: some View {
        VStack {
            // Display profile photo if present
            if let profilePhoto = viewModel.tweet.user?.profilePhotoUrl {
                KFImage(URL(string: profilePhoto))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
            } else { // Display placeholder
                Circle()
                    .frame(width: 40)
                    .foregroundColor(.twitterBlue)
                
            }
            
            Spacer()
        }
    }
    
    var header: some View {
        HStack(alignment: .bottom, spacing: 4) {
            // Unwrap user info
            if let user = viewModel.tweet.user {
                
                Text(user.name)
                    .font(.subheadline).bold()
                
                Text("@\(user.username)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Text("· 2w")
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            Spacer()
            
            Button {
                // Ellipsis actions
            } label : {
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 12, height: 3)
                    .foregroundColor(.secondary)
                    .offset(y: -5)
            }
        }
    }
    
    var tweetContent: some View {
        VStack {
            // Tweet body
            Text(viewModel.tweet.body)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            
            // Tweet image
            if let tweetImageUrl = viewModel.tweet.tweetImageUrl {
                KFImage(URL(string: tweetImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 310, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10) )
            }
        }
    }
    
    var tweetActions: some View {
        HStack {
            // Reply
            Button {
                // action
            } label: {
                Image(systemName: "bubble.left")
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Retweet
            Button {
                // action
            } label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Like(s)
            Button {
                // Has user liked tweet? Nil coalesce to false
                viewModel.tweet.didLike ?? false
                // If yes, button calls unlikeTweet()
                ? viewModel.unlikeTweet()
                // If no, button calls likeTweet()
                : viewModel.likeTweet()
                
                
            } label: {
                Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                    .font(.subheadline)
                    .foregroundColor(viewModel.tweet.didLike ?? false ? .red : .secondary)
            }
            
            Spacer()
            
            // Analytics
            Button {
                // action
            } label: {
                Image(systemName: "chart.bar.xaxis")
                    .font(.subheadline)
            }
            Spacer()
            
            // Share
            Button {
                // action
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.subheadline)
            }
        }
        .tint(.secondary)
        .padding(.vertical, 6)
    }
}
