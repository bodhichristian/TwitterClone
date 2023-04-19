//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct NewTweetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tweetText = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    // tweet
                } label: {
                    Text("Tweet")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.twitterBlue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 32)
                    .foregroundColor(.twitterBlue)
                    .padding(.leading)
                
                

                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 2) {
                        Text("Public")
                            .bold()

                        Image(systemName: "chevron.down")
                    }
                    .font(.subheadline)

                    TweetTextEditor(tweetText: $tweetText, placeholder: "What's happening?")
                        .offset(x: -6, y: -6)
                }
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
