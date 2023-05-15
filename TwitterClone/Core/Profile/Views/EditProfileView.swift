//
//  EditProfileView.swift
//  TwitterClone
//
//  Created by christian on 5/15/23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var newBio = ""
    @State private var newWebsite = ""
    @State private var uploading = false
    
    @State private var showingEditProfilePhotoView = false
    
    @State private var profileBannerImage: Image?
    @State private var selectedBannerImage: UIImage?
    @State private var showingImagePicker = false
    
    @State private var uploadingMessage: [String] = "Uploading new banner image...".map { String($0) }
    @State private var counter: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // for uploading image text animation
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                
                    if viewModel.currentUser?.profileBannerImageUrl  == nil {
                        Rectangle()
                            .frame(height: 200)
                    } else {
                        if let profileBannerImageUrl = viewModel.currentUser?.profileBannerImageUrl {
                            KFImage(URL(string: profileBannerImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)

                                .clipShape(Rectangle())

                        }
                    }
                    // If no new image has been selected, display current banner image
                        Image(uiImage: selectedBannerImage ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)

                            .clipShape(Rectangle())

                            //.padding(0)
                        
                    
                    // Upload animation
                    if uploading {
                        ZStack {
                            Rectangle()
                                .frame(height: 200)
                                .foregroundColor(.black.opacity(0.6))
                            HStack(spacing: 0) {
                                ForEach(uploadingMessage.indices, id: \.self) { index in
                                    Text(uploadingMessage[index])
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.white)
                                        .offset(y: counter == index ? -10 : 0)
                                        .shadow(radius: 4)
                                }
                            }
                        }
                        .onReceive(timer) { _ in
                            withAnimation(.spring()) {
                                let lastIndex = uploadingMessage.count - 1
                                
                                if counter == lastIndex {
                                    counter = 0
                                } else {
                                    counter += 1
                                }
                            }
                        }
                    }
  
                }
                .onTapGesture {
                    showingEditProfilePhotoView = true
                }
            
                
                
                
                
                TextField(viewModel.currentUser?.bio ?? "Add a bio.", text: $newBio)
                TextField(viewModel.currentUser?.website ?? "Add a website.", text: $newWebsite)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            .fullScreenCover(isPresented: $showingEditProfilePhotoView) {
                    ImagePicker(image: $selectedBannerImage)
            
            }
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.primary)
                    }
                }
                
                // Save button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveProfileEdits(newBio: newBio, newWebsiteUrl: newWebsite, selectedBannerImage: selectedBannerImage)

                        // Display upload in progress message
                        uploading = true
                        // Dismiss sheet after 4 seconds, so parent view has time to reload profile photo
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            // Refresh user data
                            viewModel.fetchUser()
                            // Dismiss sheet
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.twitterBlue)
                    }
                }
                
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
