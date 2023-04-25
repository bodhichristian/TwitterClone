//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/24/23.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var userAuthenticated = false
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
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
        }
    }
    
    func logOut() {
        // Ends user session locally
        userSession = nil
        // Ends user session on server
        try? Auth.auth().signOut()
    }
}


