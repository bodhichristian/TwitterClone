//
//  MainTabView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showingSideMenu = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading) {
                TabView(selection: $selectedTab){
                    FeedView(showingSideMenu: $showingSideMenu)
                        .tabItem {
                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                .environment(\.symbolVariants, .none)
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .onTapGesture {
                            selectedTab = 0
                        }
                    
                    ExploreView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                                .environment(\.symbolVariants, .none)
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .onTapGesture {
                            selectedTab = 1
                        }
                    
                    CommunitiesView()
                        .tabItem {
                            Image(systemName: selectedTab == 2 ? "person.2.fill" : "person.2")
                                .environment(\.symbolVariants, .none)
                        }
                        .onTapGesture {
                            selectedTab = 2
                        }
                    
                    NotificationsView()
                        .tabItem {
                            Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                                .environment(\.symbolVariants, .none)
                        }
                        .onTapGesture {
                            selectedTab = 3
                        }
                    
                    MessagesView()
                        .tabItem {
                            Image(systemName: selectedTab == 4 ? "envelope.fill" : "envelope")
                                .environment(\.symbolVariants, .none)
                        }
                        .onTapGesture {
                            selectedTab = 4
                        }
                }
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        ZStack {
                            Circle()
                                .foregroundColor(.twitterBlue)
                                .frame(width: 56)
                                .padding()
                            Image(systemName: "plus")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .offset(y: -48)

                    }
                }
                
                // Overlays FeedView when Side Menu is visible
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
            }
            .onAppear {
                showingSideMenu = false
            }
        }
        
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
