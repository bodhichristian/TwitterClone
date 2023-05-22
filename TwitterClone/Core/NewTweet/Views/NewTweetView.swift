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
    
    @ObservedObject var newTweetVM = UploadTweetViewModel()
    
    @State private var tweetBody = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    @FocusState private var focusTweetEditor: Bool
    
    var body: some View {
        VStack {
            headerView // Cancel, Tweet buttons
            
            tweetEditorView // Profile photo, audience, tweet body entry, optional media
            
            replyPersmissionsView // Public by default
            
            Divider()
            
            tweetExtrasView // Tweet extras buttons
        }
        .onAppear() { // Focus
            focusTweetEditor = true
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        // When didUploadTweet's change is published
        .onReceive(newTweetVM.$didUploadTweet) { success in
            if success { // Dismiss modal view
                presentationMode.wrappedValue.dismiss()
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

extension NewTweetView {

    var headerView: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .foregroundColor(.twitterBlue)
            }
            
            Spacer()
            
            Button {
                
                // FIX MEEEEEEEEEEE
                
                newTweetVM.uploadTweet(withBody: tweetBody, tweetImage: selectedImage)
                
                
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
    }
    
    var tweetEditorView: some View {
        HStack(alignment: .top) {
            
            // If no profile photo exists, display a placeholder circle
            if authVM.currentUser?.profilePhotoUrl == nil {
                Circle()
                    .frame(width: 32)
                    .foregroundColor(.twitterBlue)
                    .padding(.leading)
            } else { // If user photo exists
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
            
            
            
            // Audience, tweet body
            VStack(alignment: .leading, spacing: 0) {
                
                // Audience button
                HStack(spacing: 2) {
                    Text("Public")
                        .bold()
                    
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.twitterBlue)
                .padding(.vertical, 4)
                .padding(.horizontal, 14)
                .font(.subheadline)
                .background {
                    Capsule()
                        .strokeBorder(style: StrokeStyle())
                        .foregroundColor(.twitterBlue)
                }
                
                
                // Tweet body text editor
                TextField("What's happening?", text: $tweetBody, axis: .vertical)
                    .focused($focusTweetEditor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(selectedImage != nil ? 4 : 100)
                    .padding(.vertical, 10)
                    .padding(.trailing)

                
                // Tweet image
                ScrollView {
                    // If an image has been selected
                    if let tweetImage = selectedImage {
                        // Display tweet image
                        Image(uiImage: tweetImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(.leading, 0)
                            .padding(.trailing)
                        
                    }
                }
                Spacer()
            }
            
            
            
            
            
        }
    }
    
    var replyPersmissionsView: some View {
        HStack {
            Image(systemName: "globe.asia.australia.fill")
            Text("Everyone can reply")
            Spacer()
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundColor(.twitterBlue)
    }
    
    var tweetExtrasView: some View {
        HStack(spacing: 20) {
            Image(systemName: "mic.fill.badge.plus")
                .foregroundColor(Color(red: 0.45, green: 0.3, blue: 0.9))
            
            Image(systemName: "waveform")
            Button {
                showingImagePicker = true
            } label:{
                Image(systemName: "photo")
            }
            
            Image(systemName: "checklist")
            
            Image(systemName: "mappin.and.ellipse")
            
            Spacer()
            
            Image(systemName: "circle")
            
            Divider()
                .frame(height: 36)
                .padding(.vertical, 4)
            
            Image(systemName: "plus.circle.fill")
        }
        .foregroundColor(.twitterBlue)
        .padding(.horizontal)
    }
}
