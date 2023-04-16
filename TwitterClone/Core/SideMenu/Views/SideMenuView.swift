//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct SideMenuView: View {
    let following: Int
    let followers: Int
    let image = TwitterBlueLogo()
    
    var body: some View {
        
        VStack(alignment: .leading){
            accountOverview
            featuresView
            
            Divider()
                .padding(.horizontal, 10)
                .padding(.vertical)
            
            toolsView
        }
        .padding()
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(following: 100, followers: 900)
    }
}

extension SideMenuView {
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
    var featuresView: some View {
        ForEach(SideMenuFeaturesViewModel.allCases, id: \.rawValue) { label in
            HStack {
                
                Image(systemName: label.imageName)
                    .frame(width: 28)
                Text(label.title)
                    .foregroundColor(.primary)
            }
            .bold()
            
            .frame(height: 40)
        }
    }
    
    var toolsView: some View {
        ForEach(SideMenuToolsViewModel.allCases, id: \.rawValue){ tool in
            DisclosureGroup {
                // content
            } label: {
                HStack {
                    Text(tool.title)
                        .bold()
                    if tool == .twitterBlue {
                        TwitterBlueLogo()
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())

    }
}
