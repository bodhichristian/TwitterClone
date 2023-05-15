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
                                .clipShape(Rectangle())
                                .frame(height: 200)

                        }
                    }
                    
                    Image(uiImage: selectedBannerImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)

                        .clipShape(Rectangle())
                        .padding(0)
  
                }
                .onTapGesture {
                    showingEditProfilePhotoView = true
                }
            
                
                
                
                
                TextField(viewModel.currentUser?.bio ?? "Add a bio.", text: $newBio)
                TextField(viewModel.currentUser?.website ?? "Add a website.", text: $newWebsite)
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
                        viewModel.saveProfileEdits(newBio: newBio, selectedBannerImage: selectedBannerImage)
                        // Refresh user data
                        viewModel.fetchUser()
                        // Display upload in progress message
                        uploading = true
                        // Dismiss sheet after 3 seconds, so parent view has time to reload profile photo
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
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
