//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/24/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var userAuthenticated = false
    
    @Published var currentUser: User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("DEBUG: Did log user in")
        }
    }
    
    func register(name: String, email: String, phoneNumber: String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Account successfully created")
            
            let data = [
                "name": name,
                "email": email,
                "phoneNumber": phoneNumber,
                "username": username.lowercased(),
                "uid": user.uid
            ]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.userAuthenticated = true
                }
            
            self.fetchUser()
        }
    }
    
    func logOut() {
        // Ends user session locally
        userSession = nil
        currentUser = nil
        // Ends user session on server
        try? Auth.auth().signOut()
        print("Signed out")
    }
    
    func uploadProfilePhoto(_ image: UIImage) {
        // Check that a user is signed in
        guard let uid = userSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profilePhotoUrl in
            // Once image is uploaded, update the user's profilePhotoUrl field in Firestore
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profilePhotoUrl": profilePhotoUrl]) { error in
                    if let error = error { // Handle error
                        print("Error updating user profile photo: \(error.localizedDescription)")
                        return
                    }
                }
            self.fetchUser()
        }
    }
    
    func saveProfileEdits(newName: String?, newBio: String?, newLocation: String?, newWebsiteUrl: String?, selectedBannerImage: UIImage?, selectedProfilePhoto: UIImage?) {
        guard let uid = userSession?.uid else { return }
        
        if newName?.isEmpty == false {
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["name": newName]) { error in
                    if let error = error {
                        print("Error updating name: \(error.localizedDescription)")
                    }
                }
        }
        
        if newBio?.isEmpty == false {
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["bio": newBio]) { error in
                    if let error = error {
                        print("Error updating bio: \(error.localizedDescription)")
                    }
                }
        }
        
        if newWebsiteUrl?.isEmpty == false {
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["website": newWebsiteUrl]) { error in
                    if let error = error {
                        print("Error updating bio: \(error.localizedDescription)")
                    }
                }
        }
        
        if newLocation?.isEmpty == false {
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["location": newLocation]) { error in
                    if let error = error {
                        print("Error updating location: \(error.localizedDescription)")
                    }
                }
        }
        
        if let profileBannerImage = selectedBannerImage {
            ImageUploader.uploadImage(image: profileBannerImage) { profileBannerImage in
                Firestore.firestore().collection("users")
                    .document(uid)
                    .updateData(["profileBannerImageUrl": profileBannerImage]) { error in
                        if let error = error {
                            print("Error updating bio: \(error.localizedDescription)")
                            return
                        }
                    }
            }
        }
        
        if let profilePhoto = selectedProfilePhoto {
            ImageUploader.uploadImage(image: profilePhoto) { profilePhotoUrl in
                Firestore.firestore().collection("users")
                    .document(uid)
                    .updateData(["profilePhotoUrl": profilePhotoUrl]) { error in
                        if let error = error {
                            print("Error updating bio: \(error.localizedDescription)")
                            return
                        }
                    }
            }
        }
        
        self.fetchUser()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}


