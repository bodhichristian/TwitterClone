//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authVM: AuthViewModel
    
    @ObservedObject var uploadTweetVM = UploadTweetViewModel()
    
    @State private var tweetBody = ""
    
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
                    uploadTweetVM.uploadTweet(withBody: tweetBody)
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
                // Placeholder blue circle
                if authVM.currentUser?.profilePhotoUrl == nil {
                    Circle()
                        .frame(width: 32)
                        .foregroundColor(.twitterBlue)
                        .padding(.leading)
                } else {
                    // User profile photo, if it exists
                    if let profilePhoto = authVM.currentUser?.profilePhotoUrl {
                        KFImage(URL(string: profilePhoto))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .padding(.bottom, 5)
                            .padding(.leading)
                            
                    }
                }
                
                

                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 2) {
                        Text("Public")
                            .bold()

                        Image(systemName: "chevron.down")
                    }
                    .font(.subheadline)

                    TweetTextEditor(tweetBody: $tweetBody, placeholder: "What's happening?")
                        .offset(x: -6, y: -6)
                }
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
            .environmentObject(AuthViewModel())
    }
}
