//
//  ImageUploader.swift
//  TwitterClone
//
//  Created by christian on 4/25/23.
//
import UIKit
import Firebase
import FirebaseStorage

// Responsible for uploading images to Firebase Storage
struct ImageUploader {
    
    // Uploads image to Firebase Storage
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        
        // Convert image to jpeg data
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // Generate a unique filename using NSUUID
        let filename = NSUUID().uuidString
        // Create a reference to the Firebase Storage location where the image will be uploaded
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        // Upload image data to location specified by the reference
        ref.putData(imageData, metadata: nil) {_, error in
            if let error = error { // Handle error
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            // If successfully uploaded, generate a download URL for the image and call the completion block with the URL as a string
            ref.downloadURL { imageURL, _ in
                guard let imageURL = imageURL?.absoluteString else { return }
                completion(imageURL)
            }
        }
    }
}
