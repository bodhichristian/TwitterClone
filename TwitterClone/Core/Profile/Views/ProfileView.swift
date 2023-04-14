//
//  ProfileView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            editProfileButton
            
            VStack(alignment: .leading, spacing: 2) {
                // ID Badge
                HStack {
                    // Display Name
                    Text("The Riddler")
                        .font(.title3).fontWeight(.semibold)
                        .padding(.top, 15)
                    // Verified
                    Image(systemName: "checkmark.seal.fill")
                        .font(.caption)
                        .foregroundColor(.twitterBlue)
                        .offset(y: 8)
                }
                // @username
                Text("@enygma")
                    .font(.caption)
                    .foregroundColor(.secondary)
                // Bio
                Text("For if knowledge is power, then a god am I! \nWas that over the top❓I can never tell.")
                    .font(.subheadline)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                // Details
                HStack {
                    // Location
                    HStack(spacing: 2) {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Gotham, NY")
                        
                    }
                    // Website
                    HStack(spacing: 2) {
                        Image(systemName: "link")
                        Text("www.theriddler.com")
                    }
                    // Tenure
                    HStack(spacing: 2) {
                        Image(systemName: "calendar")
                        Text("Joined June 2012")
                    }
                }
                .font(.caption)
                .foregroundColor(.black.opacity((0.6)))

                
                HStack {
                    HStack(alignment: .bottom) {
                        Text("234")
                            .bold()
                        Text("Followers")
                            .font(.caption2)
                            .foregroundColor(.black.opacity((0.6)))

                    }
                    .font(.caption)
                    
                    HStack(alignment: .bottom) {
                        Text("211")
                            .bold()
                        Text("Following")
                            .font(.caption2)
                            .foregroundColor(.black.opacity((0.6)))

                    }
                    .font(.caption)
                }
                .padding(.vertical, 12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color.twitterBlue
                .ignoresSafeArea()
            
            // Back Arrow
            VStack {
                Button {
                    // action
                } label: {
                    BackArrow()
                        .offset(x: 2, y: 10)
                }
                
                // Profile Picture
                ZStack {
                    Circle()
                        .foregroundColor(.black)
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 3))
                        .foregroundColor(.white)
                        .frame(width: 72)
                }
                .offset(x: 16, y: 44)
            }
        }
        .frame(height: 96)
        
    }
    
    var editProfileButton: some View {
        HStack {
            Spacer()
            
            Button {
                // Edit Profile Action
            } label: {
                Text("Edit Profile")
                    .font(.caption).bold()
                    .foregroundColor(.black)
                    .frame(width: 88, height: 22)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.5), lineWidth: 0.75))
                
            }
        }
        .padding(.trailing)
    }
}
