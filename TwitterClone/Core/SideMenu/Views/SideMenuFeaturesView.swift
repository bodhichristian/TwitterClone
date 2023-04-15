//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct SideMenuFeaturesView: View {
    let following: Int
    let followers: Int
    
    var body: some View {
        
        VStack(alignment: .leading){
            accountOverview
            
            ForEach(SideMenuFeatureViewModel.allCases, id: \.rawValue) { label in
                HStack {
                    
                    Image(systemName: label.imageName)
                        .frame(width: 40)
                    Text(label.title)
                }
                .frame(height: 40)
            }
        }
        .padding()
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuFeaturesView(following: 100, followers: 900)
    }
}

extension SideMenuFeaturesView {
    var accountOverview: some View {
        HStack {
            // Display name, username, user stats
            VStack(alignment: .leading) {
                // Profile picture
                Circle()
                    .frame(width: 32)
                // Display name and blue check
                HStack {
                    Text("Bruce Wayne")
                        .font(.headline)
                    BlueCheck()
                }
                // Username
                Text("@batman")
                    .font(.caption)
                    .foregroundColor(.secondary)
                // User stats
                FollowingFollowersView(following: following, followers: followers)
                    .padding(.vertical, 1)
            }
            
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.title2)
                .offset(y: -32)
        }
    }
}
