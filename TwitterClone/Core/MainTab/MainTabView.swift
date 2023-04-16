//
//  MainTabView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            FeedView()
                .onTapGesture {
                    self.selectedTab = 0
                }
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, .none)

                }.tag(0)
            
            ExploreView()
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .environment(\.symbolVariants, .none)

                }.tag(1)
            
            
            CommunitiesView()
                .onTapGesture {
                    self.selectedTab = 2
                }
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.2.fill" : "person.2")
                        .environment(\.symbolVariants, .none)

                }.tag(2)
            
            NotificationsView()
                .onTapGesture {
                    self.selectedTab = 3
                }
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                        .environment(\.symbolVariants, .none)

                }.tag(3)
            
            MessagesView()
                .onTapGesture {
                    self.selectedTab = 4
                }
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "envelope.fill" : "envelope")
                        .environment(\.symbolVariants, .none)

                }.tag(4)
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
