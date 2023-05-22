//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by christian on 4/25/23.
//

import SwiftUI
import Kingfisher

struct EditProfilePhotoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var profilePhoto: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    @State private var uploading = false
    @State private var uploadingMessage: [String] = "Uploading new profile photo...".map { String($0) }
    @State private var counter: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // for uploading image text animation
    
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                profilePhotoView // Display user's profile photo or placeholder
                
                Spacer()
                
                editButton // Launches ImagePicker
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { // Save button
                    Button {
                        // If an image has been selected from Photos
                        if let selectedImage = selectedImage {
                            viewModel.uploadProfilePhoto(selectedImage) // Upload image
                        }
                        
                        uploading = true // Display upload in progress message
                        // Dismiss sheet after delay, so parent view has time to reload profile photo
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            dismiss() // Dismiss sheet
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(selectedImage == nil ? .gray : .twitterBlue)
                    }
                    .disabled(selectedImage == nil) // Functional if user has selected a new image
                }
            }
            // Maintains header shape
            .navigationBarTitleDisplayMode(.inline)
            // Hides default Navigation Back Button
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
        
    }
}

struct EditProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePhotoView()
            .environmentObject(AuthViewModel())
    }
}

extension EditProfilePhotoView {
    // Display user's profile photo or placeholder
    var profilePhotoView: some View {
        ZStack {
            if let profilePhotoUrl = viewModel.currentUser?.profilePhotoUrl {
                KFImage(URL(string: profilePhotoUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
            } else { // Display placeholder image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .foregroundColor(.secondary.opacity(0.4))
            }
            // User selected photo
            Image(uiImage: selectedImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .padding(0)
            
            if uploading { // Display animation
                ZStack { // Overlay
                    Circle()
                        .frame(width: 300)
                        .foregroundColor(.black.opacity(0.6))
                    HStack(spacing: 0) { // Animated text
                        ForEach(uploadingMessage.indices, id: \.self) { index in
                            Text(uploadingMessage[index])
                                .font(.title3)
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
    }
    // Launches ImagePicker
    var editButton: some View {
        HStack {
            Button {
                showingImagePicker = true
            } label: {
                Text("Edit")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
    }
}
