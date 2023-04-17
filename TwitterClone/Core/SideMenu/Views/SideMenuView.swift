//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct SideMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let image = TwitterBlueLogo()
    
    var body: some View {
        VStack(alignment: .leading){
            accountOverview
            featuresView
            
            Divider()
                .padding(.horizontal, 10)
                .padding(.vertical)
            
            toolsView
            Spacer()
            // Theme
            HStack {
                Image(systemName: colorScheme == .dark ? "moon.stars" : "sun.min")
                    .font(.title2)
                Spacer()
            }
        }
        .offset(y: -38)
        .padding(.horizontal)
        .background(colorScheme == .dark ? .black : .white)
        .frame(width: 300)
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

extension SideMenuView {
    var accountOverview: some View {
        HStack {
            // Display name, username, user stats
            VStack(alignment: .leading) {
                // Profile picture placeholder for matching position between this view and FeedView
                Circle()
                    .frame(width: 32)
                    .foregroundColor(.clear)
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
                FollowingFollowersView(following: 100, followers: 900)
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
