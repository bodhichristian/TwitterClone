//
//  SignUpView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var username = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    
    let prompt = "Create your account"
    
    var createAccountReady: Bool {
        !(
            name.isEmpty ||
            email.isEmpty ||
            phoneNumber.isEmpty ||
            username.isEmpty ||
            password.isEmpty ||
            passwordCheck.isEmpty ||
            password != passwordCheck
        )
    }
    
    var body: some View {
        // Placed inside NavigationView
        VStack {
            // To get started...
            Text(prompt)
                .multilineTextAlignment(.leading)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            registrationForm // Input user details
            
            createAccountButton // Submit registration
        }
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
        .navigationBarTitleDisplayMode(.inline) // Maintains header shape
        .navigationBarBackButtonHidden() // Hides default Navigation Back Button

    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}


extension CreateAccountView {
    private var registrationForm: some View {
        VStack(spacing: 15){
            Group {
                // Name
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.twitterBlue)
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.never)
                }
                Divider()
                
                // Email
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.twitterBlue)
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                }
                Divider()
                
                // Phone Number
                HStack {
                    Image(systemName: "phone")
                        .foregroundColor(.twitterBlue)
                    TextField("Phone number", text: $phoneNumber)
                }
                Divider()
                    .padding(.bottom, 40)
            }
            
            Group {
                // Desired username
                HStack {
                    Image(systemName: "at")
                        .foregroundColor(.twitterBlue)

                    TextField("Create a username", text: $username)
                        .textInputAutocapitalization(.never)
                }
                Divider()
                // Password
                HStack {
                    Image(systemName: "lock.shield")
                        .foregroundColor(.twitterBlue)
                    SecureField("Create a password", text: $password)
                }
                Divider()
                
                // Password Validation
                HStack {
                    Image(systemName: "lock.shield.fill")
                        .foregroundColor(.twitterBlue)
                    SecureField("Re-enter password", text: $passwordCheck)
                }
                Divider()
            }
        }
        
        .padding()
    }
    
    private var createAccountButton: some View {
        VStack{
            Spacer()
            
            Button {
                viewModel.register(name: name, email: email, phoneNumber: phoneNumber, username: username, password: password)
                
            } label: {
                Text("Create account")
                    .font(.subheadline)
                    .bold()
                    .frame(width: 300, height: 50)
                    .background(createAccountReady ? Color.twitterBlue : .secondary)
                    .foregroundColor(createAccountReady ? .white : .secondary)
                    .clipShape(Capsule())
            }
            // Disabled if userID or password are empty
            .disabled(!createAccountReady)
            .padding(.bottom)
        }
    }
}
