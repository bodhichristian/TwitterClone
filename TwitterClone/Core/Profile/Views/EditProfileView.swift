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
    @State private var updating = false
    
    @State private var profilePhoto: Image?
    @State private var selectedProfilePhoto: UIImage?
    @State private var pickingProfilePhoto = false
    
    @State private var profileBannerImage: Image?
    
    @State private var pickingBannerImage = false
    @State private var selectedBannerImage: UIImage?
    
    @State private var editsHaveBeenMade = false
    
    @State private var updatingProfileMessage: [String] = "Updating profile...".map { String($0) }
    @State private var counter: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // for uploading image text animation
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    bannerImageSelector // Reveal ImagePicker on tap gesture
                    
                    profileImageSelector // Reveal ImagePicker on tap gesture
                    
                    profileDetailsForm // Name, @username, location, website
                    
                    additionalTools // Switch to professional, Tips
 
                    Spacer()
                }
                
                if updating { // Display upload animation, while edits update
                    Rectangle() // Dark, transparent overlay
                        .ignoresSafeArea()
                        .foregroundColor(.black.opacity(0.6))
                    HStack(spacing: 0) { // Animating text
                        ForEach(updatingProfileMessage.indices, id: \.self) { index in
                            Text(updatingProfileMessage[index])
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: counter == index ? -10 : 0)
                                .shadow(radius: 4)
                        }
                    }
                    .onReceive(timer) { _ in
                        withAnimation(.spring()) {
                            let lastIndex = updatingProfileMessage.count - 1
                            
                            if counter == lastIndex {
                                counter = 0
                            } else {
                                counter += 1
                            }
                        }
                    }
                }
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
                ToolbarItem(placement: .navigationBarLeading) { // Cancel button
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) { // Save button
                    Button {
                        viewModel.saveProfileEdits(newName: newName,
                                                   newBio: newBio,
                                                   newLocation: newLocation,
                                                   newWebsiteUrl: newWebsite,
                                                   selectedBannerImage: selectedBannerImage,
                                                   selectedProfilePhoto: selectedProfilePhoto)
                        updating = true // Display upload in progress message
                        // Delay dismissal to buffer for updating images
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // Dismiss sheet after 4 seconds
                            viewModel.fetchUser() // Refresh user data
                            dismiss() // Dismiss sheet
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(editsHaveBeenMade ? .twitterBlue : .clear) // Visible if edits hae been made
                    }
                    .disabled(editsHaveBeenMade == false) // Functional if edits have been made
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
    // Reveal ImagePicker on tap gesture
    var bannerImageSelector: some View {
        ZStack {
            // If user does not have a banner image
            if viewModel.currentUser?.profileBannerImageUrl  == nil {
                // Placeholder - blue rectangle
                Rectangle()
                    .frame(width: 400, height: 150)
                    .foregroundColor(.twitterBlue)
            } else { // If user has a banner image
                if let profileBannerImageUrl = viewModel.currentUser?.profileBannerImageUrl {
                    KFImage(URL(string: profileBannerImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400, height: 150)
                        .clipShape(Rectangle())
                    
                }
            }
            
            // User-selected image
            Image(uiImage: selectedBannerImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 150)
            
                .clipShape(Rectangle())
            
            
        }
        .offset(y: -10)
        .onTapGesture {
            pickingBannerImage = true
            editsHaveBeenMade = true
        }
    }
    // Reveal ImagePicker on tap gesture
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
                editsHaveBeenMade = true
            }
            
            Spacer()
        }
        .offset(y: -40)
        .padding(.horizontal)
        .padding(.bottom, -55)
    }
    // Name, @username, location, website
    var profileDetailsForm: some View {
        VStack {
            Divider()
                .padding(.top)
            
            // Name
            VStack {
                HStack {
                    ZStack(alignment: .bottomLeading) { // Prompt
                        Rectangle()
                            .frame(width: 70, height: 20)
                            .foregroundColor(.clear)
                        Text("Name")
                            .font(.callout)
                            .bold()
                    }
                    // User input
                    TextField(viewModel.currentUser?.name ?? "Add a name", text: $newName)
                        .textInputAutocapitalization(.never)
                        .font(.callout)
                        .foregroundColor(.twitterBlue)
                        .onChange(of: newName) { _ in
                            editsHaveBeenMade = true
                        }
                }
                .padding(.horizontal)
                
                Divider()
            }
            // Bio
            VStack{
                HStack(alignment: .top) {
                    ZStack(alignment: .bottomLeading) { // Prompt
                        Rectangle()
                            .frame(width: 70, height: 20)
                            .foregroundColor(.clear)
                        Text("Bio")
                            .font(.callout)
                            .bold()
                    }
                    // User input
                    TextField(viewModel.currentUser?.bio ?? "Add a bio", text: $newBio, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                        .textInputAutocapitalization(.never)
                        .font(.callout)
                        .foregroundColor(.twitterBlue)
                        .onChange(of: newBio) { _ in
                            editsHaveBeenMade = true
                        }
                }
                .padding(.horizontal)
                
                Divider()
            }
            // Location
            VStack {
                HStack {
                    ZStack(alignment: .bottomLeading) { // Prompt
                        Rectangle()
                            .frame(width: 70, height: 20)
                            .foregroundColor(.clear)
                        Text("Location")
                            .font(.callout)
                            .bold()
                    }
                    // User input
                    TextField(viewModel.currentUser?.location ?? "Add a location", text: $newLocation)
                        .textInputAutocapitalization(.never)
                        .font(.callout)
                        .foregroundColor(.twitterBlue)
                        .onChange(of: newLocation) { _ in
                            editsHaveBeenMade = true
                        }
                }
                .padding(.horizontal)
                
                Divider()
            }
            // Website
            VStack {
                HStack {
                    ZStack(alignment: .bottomLeading) { // Prompt
                        Rectangle()
                            .frame(width: 70, height: 20)
                            .foregroundColor(.clear)
                        Text("Website")
                            .font(.callout)
                            .bold()
                        
                    }
                    // User input
                    TextField(viewModel.currentUser?.website ?? "Add a website", text: $newWebsite)
                        .textInputAutocapitalization(.never)
                        .font(.callout)
                        .foregroundColor(.twitterBlue)
                        .onChange(of: newLocation) { _ in
                            editsHaveBeenMade = true
                        }
                    
                    
                }
                .padding(.horizontal)
                Divider()
            }        }
    }
    // Switch to professional, Tips
    var additionalTools: some View {
        VStack {
            // Switch to Professional
            NavigationLink { // Placeholder view
                Text("Placeholder")
            } label: {
                VStack {
                    HStack { // Tool name
                        Text("Switch to Professional")
                            .font(.callout)
                            .bold()
                        
                        Spacer()
                        // Button label
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
                    HStack { // Tool name
                        Text("Tips")
                            .font(.callout)
                            .bold()
                        
                        Spacer()
                        // Button label
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
        }
    }
}
