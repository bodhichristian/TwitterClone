//
//  ContinueWithButton.swift
//  TwitterClone
//
//  Created by christian on 4/23/23.
//

import SwiftUI

// Placeholder UI elements for Sign-In with Apple/Google
struct AuthenticationOptionButton: View {
    let title: String
    let imageName: String
    
    var body: some View {
            ZStack {
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: 320, height: 44)
                
                Capsule()
                    .stroke(Color.secondary, lineWidth: 0.2)
                    .foregroundColor(.white)
                    .frame(width: 320, height: 44)

                HStack(spacing: 14) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .offset(x: imageName == "" ? -14 : 0 )
                }
            }
            .foregroundColor(.black)
    }
}

struct ContinueWithButton_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationOptionButton(title: "Apple", imageName: "appleLogo")
    }
}
