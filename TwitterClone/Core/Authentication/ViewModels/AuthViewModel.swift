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
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(userID: String, password: String) {
        print("DEBUG login func called")
    }
    
    func register(name: String, email: String, phoneNumber: String, username: String, password: String) {
        print("DEBUG register func called")
    }
}



//
//@State private var name = ""
//@State private var email = ""
//@State private var phonenumber = ""
//@State private var username = ""
//@State private var password = ""
//@State private var passwordCheck = ""
