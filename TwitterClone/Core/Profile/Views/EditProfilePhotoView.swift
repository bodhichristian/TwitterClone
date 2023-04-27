//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by christian on 4/25/23.
//

import SwiftUI
import Kingfisher

struct EditProfilePhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var profilePhoto: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    @State private var uploading = false
    @State private var uploadingMessage: [String] = "Uploading new profile photo...".map { String($0) }
    @State private var counter: Int = 0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    
    var body: some View {
        NavigationView{
            ZStack {
                if viewModel.currentUser?.profilePhotoUrl == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .foregroundColor(.secondary.opacity(0.4))
                } else {
                    if let photoUrl = viewModel.currentUser?.profilePhotoUrl {
                        KFImage(URL(string: photoUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(Circle())
                            
                    }
                }
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)

                    .clipShape(Circle())

                    .padding(0)
                
                if uploading {
                    ZStack {
                        Circle()
                            .frame(width: 300)
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

                
                VStack {
                    Spacer()
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
            .padding()
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.primary)
                    }
                    .tint(.twitterBlue)
                }
                // Save button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // If an image has been selected from Photos
                        if let selectedImage = selectedImage {
                            // Upload image
                            viewModel.uploadProfilePhoto(selectedImage)
                        }
                        // Refresh user data
                        viewModel.fetchUser()
                        // Display upload in progress message
                        uploading = true
                        // Dismiss sheet after 3 seconds, so parent view has time to reload profile photo
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            // Dismiss sheet
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.twitterBlue)
                    }
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
