//
//  EditProfileView.swift
//  TwitterClone
//
//  Created by christian on 5/15/23.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
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
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    // If an image has been selected from Photos
//                    if let selectedImage = selectedImage {
//                        // Upload image
//                        viewModel.uploadProfilePhoto(selectedImage)
//                    }
//                    // Refresh user data
//                    viewModel.fetchUser()
//                    // Display upload in progress message
//                    uploading = true
//                    // Dismiss sheet after 3 seconds, so parent view has time to reload profile photo
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                        // Dismiss sheet
//                        dismiss()
//                    }
//                } label: {
//                    Text("Save")
//                        .foregroundColor(.twitterBlue)
//                }
//            }
            
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
