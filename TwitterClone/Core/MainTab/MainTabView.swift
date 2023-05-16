//
//  MainTabView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    //@ObservedObject var exploreVM = ExploreViewModel()
    
    @State private var selectedTab = 0
    @State private var showingSideMenu = false
    @State private var showingNewTweetView = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading) {
                TabView(selection: $selectedTab){
                    FeedView(showingSideMenu: $showingSideMenu)
                        .tabItem {
                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(0)
                        .toolbarBackground(.visible, for: .tabBar)
                        .onTapGesture {
                            showingSideMenu = false
                        }
                    
                    ExploreView(showingSideMenu: $showingSideMenu)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(1)
                        .toolbarBackground(.visible, for: .tabBar)
                        .onTapGesture {
                            showingSideMenu = false
                            
                        }
                    
                    
                    CommunitiesView()
                        .tabItem {
                            Image(systemName: selectedTab == 2 ? "person.2.fill" : "person.2")
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(2)
                        .onTapGesture {
                            showingSideMenu = false
                            
                        }
                    
                    NotificationsView()
                        .tabItem {
                            Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(3)
                        .onTapGesture {
                            showingSideMenu = false
                            
                        }
                    
                    MessagesView()
                        .tabItem {
                            Image(systemName: selectedTab == 4 ? "envelope.fill" : "envelope")
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(4)
                        .onTapGesture {
                            showingSideMenu = false
                            
                        }
                }
                // Overlays backgroung when Side Menu is visible
                // Tapping on black background pushes SideMenuView off screen
                if showingSideMenu {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showingSideMenu = false
                            }
                        }
                }
                
                SideMenuView()
                    .offset(x: showingSideMenu ? 0 : -400)
                // After user travels away from menu, it is hidden offscreen to ensure a HomeTab reset
                    .onDisappear {
                        showingSideMenu = false
                    }
                
                newTweetButton
                    .offset(x: showingSideMenu ? 100 : 0, y: -48)
            }

            // Maintains header shape
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
        
    }
}

extension MainTabView {
    var newTweetButton: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                Spacer()
                Button {
                    showingNewTweetView = true
                }label:{
                    ZStack {
                        Circle()
                            .foregroundColor(.twitterBlue)
                            .frame(width: 56)
                            .padding()
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        //.frame(width: 56, height: 56)
                    }
                    .fullScreenCover(isPresented: $showingNewTweetView) {
                        NewTweetView()
                    }
                }
                
            }
        }
    }
}
