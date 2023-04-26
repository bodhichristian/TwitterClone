//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by christian on 4/25/23.
//

import SwiftUI

struct EditProfilePhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var profilePhoto: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .foregroundColor(.secondary.opacity(0.4))
                
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)

                    .clipShape(Circle())

                    .padding(0)

                
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            showingImagePicker = true
                        } label: {
                            Text("Edit")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.leading, 30)
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
                // Twitter logo
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if let selectedImage = selectedImage {
                            viewModel.uploadProfilePhoto(selectedImage)
                        }
                        presentationMode.wrappedValue.dismiss()
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
