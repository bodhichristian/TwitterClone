//
//  LogInView.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct LogInView: View {
    @Environment (\.presentationMode) var presentationMode
    
    let prompt = "To get started, first enter your phone, email, or @username"
    let passwordResetURL = URL(string: "https://twitter.com/account/begin_password_reset")!
    let loginTitleKey = "Phone, email, or @username"
    
    @State private var loginCredential = ""
    @State private var showingPasswordField = false
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(prompt)
                    .font(.title)
                    .bold()
                
                TextField(loginTitleKey, text: $loginCredential)
                
                Divider()
                    .padding(0)
                Spacer()
                
                // Footer tools
                HStack {
                    Link("Forgot password?", destination: passwordResetURL)
                    
                    Spacer()
                    
                    Button {
                        // 
                    } label: {
                        Text("Next")
                            .font(.subheadline)
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(loginCredential.isEmpty ? .secondary : Color.twitterBlue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .disabled(loginCredential.isEmpty)
                
                }
            }
            .padding()
            .toolbar {
                // Profile picture, side menu reveal
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
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
