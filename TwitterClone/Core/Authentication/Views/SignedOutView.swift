//
//  SignedOutView.swift
//  TwitterClone
//
//  Created by christian on 4/23/23.
//

import SwiftUI

struct SignedOutView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            createAccountOptions // Continue with Apple/Google, Create Account
            
            termsView // Terms prompt
            
            logInPrompt // Log in for established users
 
        }
    }
}


struct SignedOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignedOutView()
            .preferredColorScheme(.dark)
    }
}

extension SignedOutView {
    private var createAccountOptions: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading){
                Text("Introduce yourself. Join Twitter to create your Profile.")
                    .font(.title2)
                    .bold()
            }
            
            Spacer()
            
            Button {
                // Action
            } label: {
                AuthenticationOptionButton(title: "Continue with Apple", imageName: "appleLogo")
            }
            Button {
                // Action
            } label: {
                AuthenticationOptionButton(title: "Continue with Google", imageName: "googleLogo")
            }
            
            orDivider
            
            NavigationLink {
                CreateAccountView()
            } label: {
                AuthenticationOptionButton(title: "Create account", imageName: "")
            }
        }
    }
    // -OR-
    private var orDivider: some View {
        HStack {
            VStack {
                Divider()
            }
            Text("OR")
                .font(.caption2)
            VStack {
                Divider()
            }
            .foregroundColor(colorScheme == .dark ? .white : .secondary)
            
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 40)
    }
    
    private var termsView: some View {
        VStack(alignment: .leading) {
            (
                Text("By signing up, you agree to our ") +
                Text("Terms").foregroundColor(.twitterBlue) +
                Text(", ") +
                Text("Privacy Policy").foregroundColor(.twitterBlue) +
                Text(", and ") +
                Text("Cookie Use").foregroundColor(.twitterBlue) +
                Text(".")
                
            )
            .font(.caption2)
            .padding(.bottom, 80)
        }
        .padding()
    }
    
    private var logInPrompt: some View {
        HStack(spacing: 0) {
            Text("Have an account already? ")
            NavigationLink("Log in", destination: LogInView())
                .fontWeight(.semibold)
                .foregroundColor(.twitterBlue)
            
            Spacer()
        }
        .font(.caption)
        .padding(.leading, 40)
    }
}
