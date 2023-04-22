//
//  SignUpView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var email = ""
    @State private var phonenumber = ""
    @State private var username = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    
    let prompt = "Create your account"
    
    var createAccountReady: Bool {
        !(
            name.isEmpty ||
            email.isEmpty ||
            phonenumber.isEmpty ||
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
            
            registrationForm
            
            createAccountButton
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
        // Maintains header shape
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}


extension CreateAccountView {
    var registrationForm: some View {
        VStack(spacing: 15){
            Group {
                // Name
                HStack {
                    Image(systemName: "person")
                    TextField("Name", text: $name)
                }
                Divider()
                
                // Email
                HStack {
                    Image(systemName: "envelope")
                    TextField("Email", text: $email)
                }
                Divider()
                
                // Phone Number
                HStack {
                    Image(systemName: "phone")
                    TextField("Phone number", text: $phonenumber)
                }
                Divider()
            }
            
            Group {
                // Desired username
                HStack {
                    Image(systemName: "at")
                    TextField("Create a username", text: $username)
                }
                Divider()
                // Password
                HStack {
                    Image(systemName: "lock.shield")
                    TextField("Password", text: $password)
                }
                Divider()
                
                // Password Validation
                HStack {
                    Image(systemName: "lock.shield.fill")
                    TextField("Re-enter password", text: $passwordCheck)
                }
                Divider()
            }
        }
        .padding()
    }
    
    var createAccountButton: some View {
        VStack{
            Spacer()
            
            Button {
                //
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
