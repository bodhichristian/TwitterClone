//
//  UserRowView.swift
//  TwitterClone
//
//  Created by christian on 4/14/23.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .top) {
            // Profile picture
            KFImage(URL(string: user.profilePhotoUrl ?? ""))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 45, height: 45)
                .foregroundColor(.twitterBlue)
            
            // Display name, username
            VStack(alignment: .leading, spacing: 2) {
                // Name
                HStack(spacing: 0){
                    Text(user.name)
                        .bold()
                    BlueCheck()
                        .padding(.horizontal, 4)
                }
                // Username
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                // Relationship
                HStack(alignment: .top, spacing: 2) {
                    Image(systemName:"person.fill")
                        .foregroundColor(.primary.opacity(0.6))
                    
                    Text("Following")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User.example)
    }
}
