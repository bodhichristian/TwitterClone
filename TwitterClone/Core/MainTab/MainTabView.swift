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
                
                newTweetButton
                    .offset(x: showingSideMenu ? 100 : 0, y: -48)
            }
        }
    }
}
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
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
