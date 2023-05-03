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
            HStack {
                Button {
                    showingSideMenu = true
                } label: {
                    if let profilePhoto = authVM.currentUser?.profilePhotoUrl {
                        KFImage(URL(string: profilePhoto))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .padding(.leading, 5)
                        
                    } else {
                        Circle()
                            .frame(width: 32)
                            .foregroundColor(.twitterBlue)
                            .padding(.leading, -4)
                    }
                }
                
                
                SearchBar(text: $exploreVM.searchText)
                    .opacity(showingSideMenu ? 0 : 1)
                
                
                Button {
                    showingExploreSettingsView = true
                } label: {
                    Image(systemName: "gear")
                        .font(.title2)
                        .foregroundColor(.primary)
                }.offset(x: showingSideMenu ? 100 : 0)
            }
            .padding(.horizontal)
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
