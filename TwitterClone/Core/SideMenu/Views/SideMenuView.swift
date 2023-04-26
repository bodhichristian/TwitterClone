//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct SideMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: AuthViewModel
    
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
        .padding(.horizontal)
        .background(colorScheme == .dark ? .black : .white)
        .frame(width: 320)
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
                // Profile image/button
                NavigationLink {
                    ProfileView()
                } label: {
                    // Profile picture
                    Circle()
                        .frame(width: 32)
                        .foregroundColor(.twitterBlue)
                }

                // Display name and blue check
                if let currentUser = viewModel.currentUser {
                    HStack {
                        Text(currentUser.name)
                            .font(.headline)
                        BlueCheck()
                    }
                    .padding(.top)
                    // Username
                    Text("@\(currentUser.username)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                
                // User stats
                FollowingFollowersView(following: 100, followers: 900)
                    .padding(.vertical, 1)
            }
            
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.title2)
                .offset(y: -32)
        }
        .padding(.bottom)
    }
    var featuresView: some View {
        ForEach(SideMenuFeaturesViewModel.allCases, id: \.rawValue) { label in
            NavigationLink {
                switch label {
                case .profile : ProfileView()
                // Add a case for each SideMenuFeaturesViewModel cases
                    
                default: Text(label.title)
                }
            } label: {
                HStack {
                    
                    Image(systemName: label.imageName)
                        .frame(width: 28)
                    Text(label.title)
                        .foregroundColor(.primary)
                }
                .fontWeight(.semibold)
                
                .frame(height: 48)
            }
            .buttonStyle(PlainButtonStyle())

        }
    }
    
    var toolsView: some View {
        ForEach(SideMenuToolsViewModel.allCases, id: \.rawValue){ tool in
            DisclosureGroup {
                if tool == .settingsAndSupport {
                    // Log Out Button
                    Button {
                        viewModel.logOut()
                    } label: {
                        HStack {
                            Label("Log Out", systemImage: "door.right.hand.open")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .padding(.top)
                            Spacer()
                        }
                    }
                }
            } label: {
                HStack {
                    Text(tool.title)
                        .font(.callout)
                        .fontWeight(.semibold)
                    if tool == .twitterBlue {
                        TwitterBlueLogo()
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())

    }
}
