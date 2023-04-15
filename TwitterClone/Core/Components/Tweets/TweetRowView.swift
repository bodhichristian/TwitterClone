//
//  TweetRowView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Profile Image, user info, tweet
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .frame(width: 45)
                    .foregroundColor(.twitterBlue)
                
                // User info, tweet body
                VStack(alignment: .leading, spacing: 4) {
                    // User info
                    HStack(alignment: .bottom) {
                        Text("Bruce Wayne")
                            .font(.subheadline).bold()
                        
                        Text("@batman")
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
                    
                    // Tweet body
                    Text("I believe in Harvey Dent.")
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
        TweetRowView()
    }
}
