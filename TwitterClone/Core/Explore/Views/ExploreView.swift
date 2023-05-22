//
//  ExploreView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct ExploreView: View {
    @ObservedObject var exploreVM = ExploreViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    @Binding var showingSideMenu: Bool
    
    @State private var showingExploreSettingsView = false
    
    var body: some View {
        VStack {
            header // Profile photo, search bar, settings
            
            searchResults
        }
        .fullScreenCover(isPresented: $showingExploreSettingsView) {
            ExploreSettingsView()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(exploreVM: ExploreViewModel(), showingSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
    }
}

extension ExploreView {
    // Profile photo, search bar, settings
    private var header: some View {
        HStack {
            // Profile Photo Button
            Button {
                withAnimation{
                    showingSideMenu = true
                }
            } label: {
                // If logged in user has a profile photo
                if let profilePhoto = authVM.currentUser?.profilePhotoUrl {
                    // Fetch and display profile photo
                    KFImage(URL(string: profilePhoto))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                } else {
                    // Placeholder
                    Circle()
                        .frame(width: 32)
                        .foregroundColor(.twitterBlue)
                }
            }
            .offset(y: -3)
            
            
            SearchBar(text: $exploreVM.searchText)
                .opacity(showingSideMenu ? 0 : 1) // Transparent if showing side menu

            
            
            Button {
                showingExploreSettingsView = true
            } label: {
                Image(systemName: "gear")
                    .font(.title2)
                    .foregroundColor(.primary)
            }.opacity(showingSideMenu ? 0 : 1) // Transparent if showing side menu
        }
        .padding(.horizontal)
    }
    // Search results
    private var searchResults: some View {
        ScrollView {
            LazyVStack {
                ForEach(exploreVM.searchableUsers) { user in
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        UserRowView(user: user)
                    }
                }
            }
        }
    }
}
