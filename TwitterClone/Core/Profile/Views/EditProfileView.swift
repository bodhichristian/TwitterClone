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
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var newBio = ""
    @State private var newWebsite = ""
    @State private var newLocation = ""
    @State private var newName = ""
    @State private var uploading = false
    
    @State private var profilePhoto: Image?
    @State private var selectedProfilePhoto: UIImage?
    @State private var pickingProfilePhoto = false
    
    @State private var profileBannerImage: Image?
    
    @State private var pickingBannerImage = false
    @State private var selectedBannerImage: UIImage?
    
    
    @State private var uploadingMessage: [String] = "Uploading new banner image...".map { String($0) }
    @State private var counter: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // for uploading image text animation
    
    var body: some View {
        NavigationView {
            VStack {
                bannerImageSelector
                
                profileImageSelector
                
                
                
                Divider()
                    .padding(.top)
                
                
                // CLEAN ME UP!!!
                
                // Name
                VStack {
                    HStack {
                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .frame(width: 70, height: 20)
                                .foregroundColor(.clear)
                            Text("Name")
                                .font(.callout)

                                .bold()
                            
                        }
                        TextField(viewModel.currentUser?.name ?? "Add a name", text: $newName)
                            .textInputAutocapitalization(.never)
                            .font(.callout)
                            .foregroundColor(.twitterBlue)

                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                
                
                // Bio
                VStack{
                    HStack(alignment: .top) {
                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .frame(width: 70, height: 20)
                                .foregroundColor(.clear)
                            Text("Bio")
                                .font(.callout)

                                .bold()
                            
                        }
                        TextField(viewModel.currentUser?.bio ?? "Add a bio", text: $newBio, axis: .vertical)
                            .lineLimit(3, reservesSpace: true)
                            .textInputAutocapitalization(.never)
                            .font(.callout)

                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                
                
                // Location
                VStack {
                    HStack {
                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .frame(width: 70, height: 20)
                                .foregroundColor(.clear)
                            Text("Location")
                                .font(.callout)

                                .bold()
                            
                        }
                        TextField("Add a location", text: $newLocation)
                            .textInputAutocapitalization(.never)
                            .font(.callout)

                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                
                
                
                // Website
                VStack {
                    HStack {
                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .frame(width: 70, height: 20)
                                .foregroundColor(.clear)
                            Text("Website")
                                .font(.callout)

                                .bold()
                            
                        }
                        TextField(viewModel.currentUser?.website ?? "Add a website", text: $newWebsite)
                            .textInputAutocapitalization(.never)
                            .font(.callout)

                    }
                    .padding(.horizontal)
                    Divider()
                }
                
                
                
                
                
                
                // Switch to Professional
                NavigationLink {
                    Text("Placeholder")
                } label: {
                    VStack {
                        HStack {
                            Text("Switch to Professional")
                                .font(.callout)

                                .bold()
                            
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.callout)

                        }
                        .frame(height: 20)
                        .padding(.horizontal)
                        Divider()
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                // Tips
                NavigationLink {
                    Text("Placeholder")
                } label: {
                    VStack {
                        Divider()
                        HStack {
                            Text("Tips")
                                .font(.callout)

                                .bold()
                            
                            Spacer()
                            Text("Off")
                                .font(.callout)
                            Image(systemName: "chevron.right")
                        }
                        .frame(height: 20)
                        
                        .padding(.horizontal)
                        Divider()
                    }
                    .padding(.top, 40)
                }
                .buttonStyle(PlainButtonStyle())
                
                
                
                
                
                
                
                
                
                
                Spacer()
                
            }
            // Banner Image Picker
            .fullScreenCover(isPresented: $pickingBannerImage) {
                ImagePicker(image: $selectedBannerImage)
                
            }
            // Profile Photo Image Picker
            .fullScreenCover(isPresented: $pickingProfilePhoto) {
                ImagePicker(image: $selectedProfilePhoto)
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit profile")
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(AuthViewModel())
    }
}


extension EditProfileView {
    var bannerImageSelector: some View {
        ZStack {
            // If user does not have a banner image
            if viewModel.currentUser?.profileBannerImageUrl  == nil {
                // Placeholder - blue rectangle
                Rectangle()
                    .frame(height: 170)
                    .foregroundColor(.twitterBlue)
            } else { // If user has a banner image
                if let profileBannerImageUrl = viewModel.currentUser?.profileBannerImageUrl {
                    KFImage(URL(string: profileBannerImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(Rectangle())
                    
                }
            }
            
            // User-selected image
            Image(uiImage: selectedBannerImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            
                .clipShape(Rectangle())
            
            
            
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
        .offset(y: -10)
        .onTapGesture {
            pickingBannerImage = true
        }
    }
    
    var profileImageSelector: some View {
        HStack {
            ZStack{
                // If user does not have a profile photo
                if viewModel.currentUser?.profilePhotoUrl == nil {
                    ZStack {
                        Circle()
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .frame(width: 64)
                        
                        
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .foregroundColor(.secondary.opacity(0.4))
                    }
                } else { // If user has a profile photo
                    if let photoUrl = viewModel.currentUser?.profilePhotoUrl {
                        KFImage(URL(string: photoUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                    }
                }
                
                // User selected profile photo
                Image(uiImage: selectedProfilePhoto ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(0)
                
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.black.opacity(0.3))
                
                
                // Camera icon overlay
                Image(systemName: "camera")
                    .font(.title).bold()
                    .foregroundColor(.white)
                
                
            }
            .onTapGesture {
                pickingProfilePhoto = true
            }
            
            if uploading {
                ZStack {
                    Circle()
                        .frame(width: 60)
                        .foregroundColor(.black.opacity(0.6))
                    HStack(spacing: 0) {
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
            Spacer()
        }
        .offset(y: -55)
        .padding(.horizontal)
        .padding(.bottom, -55)
    }
    
    
}
