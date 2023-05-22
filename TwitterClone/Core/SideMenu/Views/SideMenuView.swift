//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showingLogOutAlert = false
    @State private var logOutAlertMessage = Text("Are you sure you want to log out?")
    @State private var logOutAlertTitle = Text("Log Out")
    
    let image = TwitterBlueLogo()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                accountOverview // Profile photo, network, add
                featuresView
                
                Divider()
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                
                toolsView
                
                Spacer()
                
                themeIndicator
            }
            .padding(.horizontal)
            .background(colorScheme == .dark ? .black : .white)
            .frame(width: 320)
            
            .alert(isPresented: $showingLogOutAlert, content: {
                Alert(title: logOutAlertTitle,
                      message: logOutAlertMessage,
                      primaryButton: .default(Text("Go back")),
                      secondaryButton: .destructive(
                        Text("Log out"),
                        action: {
                            viewModel.logOut()
                        }))
        })
            Spacer()
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
            .environmentObject(AuthViewModel())
    }
}

extension SideMenuView {
    var accountOverview: some View {
        HStack {
            // Display name, username, user stats
            VStack(alignment: .leading) {
                // Profile image/button
                NavigationLink {
                    ProfileView(user: viewModel.currentUser ?? User.empty)
                } label: {
                    // Profile picture
                    if viewModel.currentUser?.profilePhotoUrl == nil {
                        Circle()
                            .frame(width: 32)
                            .foregroundColor(.twitterBlue)
                    } else {
                        if let profilePhoto = viewModel.currentUser?.profilePhotoUrl {
                            KFImage(URL(string: profilePhoto))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                                .padding(.bottom, 5)
                            
                        }
                    }
                }
                
                // Display name and blue check
                if let currentUser = viewModel.currentUser {
                    HStack(spacing: 4) {
                        Text(currentUser.name)
                            .font(.headline)
                        BlueCheck()
                    }
                    //.padding(.top)
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
                case .profile : ProfileView(user: viewModel.currentUser ?? User.empty)
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
                        showingLogOutAlert = true
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
    
    var themeIndicator: some View {
        HStack {
            Image(systemName: colorScheme == .dark ? "moon.stars" : "sun.min")
                .font(.title2)
            Spacer()
        }
        .padding(.bottom, 10)
    }
}
