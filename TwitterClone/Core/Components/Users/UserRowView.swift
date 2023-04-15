//
//  UserRowView.swift
//  TwitterClone
//
//  Created by christian on 4/14/23.
//

import SwiftUI

struct UserRowView: View {
    var body: some View {
        HStack(alignment: .top) {
            // Profile picture
            Circle()
                .frame(width: 45)
                .foregroundColor(.twitterBlue)
            // Display name, username
            VStack(alignment: .leading, spacing: 2) {
                HStack{
                    Text("The Riddler")
                        .bold()
                    BlueCheck()
                }
                Text("@enygma")
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
        UserRowView()
    }
}
