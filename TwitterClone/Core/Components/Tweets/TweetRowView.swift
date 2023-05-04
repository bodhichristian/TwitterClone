//
//  TweetRowView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading) {
            // Profile Image, user info, tweet
            HStack(alignment: .top, spacing: 12) {
                if let profilePhoto = tweet.user?.profilePhotoUrl {
                    KFImage(URL(string: profilePhoto))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40)
                        .clipShape(Circle())
                        .offset(y: -12)
                    
                } else {
                    Circle()
                        .frame(width: 40)
                        .foregroundColor(.twitterBlue)
                    
                }
                
                // User info, tweet body
                VStack(alignment: .leading, spacing: 4) {
                    
                    // User info
                    
                    
                    if let user = tweet.user {
                        HStack(alignment: .bottom, spacing: 4) {
                            Text(user.name)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                            
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
                    
                    
                    
                    // Tweet body
                    Text(tweet.body)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Button {
                            // action
                        } label: {
                            Image(systemName: "bubble.left")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            // action
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            // action
                        } label: {
                            Image(systemName: "heart")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button {
                            // action
                        } label: {
                            Image(systemName: "chart.bar.xaxis")
                                .font(.subheadline)
                        }
                        Spacer()
                        
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
            .padding(.horizontal)
            .padding(.top, 4)
            // Action buttons
            
            
            
            // Divider
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.secondary.opacity(0.3))
        }
        // .padding()
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView(tweet: Tweet.example)
    }
}
