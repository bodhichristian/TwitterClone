//
//  LogInView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct LogInView: View {
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    let prompt = "To get started, enter your email, followed by your password."
    let passwordResetURL = URL(string: "https://twitter.com/account/begin_password_reset")!
    let loginTitleKey = "Email" // Placeholder text for loginCredential TextField
    let passwordTitleKey = "Password" // Placeholder text for password TextField
    
    @State private var userID = ""
    @State private var password = ""
    
    var logInReady: Bool { // Returns true if userID and password have values
        !(userID.isEmpty || password.isEmpty)
    }
    
    var body: some View {
        // Placed inside NavigationView
        VStack(alignment: .leading) {
                    // To get started...
                    Text(prompt)
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                    // UserID and password
                    credentialEntry
                    // Log in and Forgot Password?
                    logInButtons
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
                ToolbarItem(placement: .principal) {
                    TwitterLogo()
                        .padding(8)
                }
            }
            // Maintains header shape
            .navigationBarTitleDisplayMode(.inline)
            // Hides default Navigation Back Button
            .navigationBarBackButtonHidden()

    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


extension LogInView {
    var credentialEntry: some View {
        VStack{
            // Phone, email, or @username
            TextField(loginTitleKey, text: $userID)
                .textInputAutocapitalization(.never)
            Divider()
                .padding(0)
            
            // Password
            SecureField(passwordTitleKey, text: $password)
                .padding(.top, 10)
            Divider()
                .padding(0)
        }
    }
    
    var logInButtons: some View {
        HStack{
            Spacer()
            
            VStack {
                Spacer()
                // Log in button
                Button {
                    viewModel.logIn(email: userID, password: password)
                } label: {
                    Text("Log in")
                        .font(.subheadline)
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(logInReady ? Color.twitterBlue : .secondary)
                        .foregroundColor(logInReady ? .white : .secondary)
                        .clipShape(Capsule())
                }
                // Disabled if userID or password are empty
                .disabled(!logInReady)
                
                // Forgot password?
                Link(destination: passwordResetURL){
                    Text("Forgot password?")
                    .underline()
                    .bold()
                    .foregroundColor(.primary)
                    .padding()
                }
            }
            
            Spacer()
        }
    }
}
