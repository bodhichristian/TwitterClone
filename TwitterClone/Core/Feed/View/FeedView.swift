//
//  FeedView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Namespace var animation // For animating blue bar in tweetFilter
    @State private var selectedFeed: FeedType = .forYou
    @Binding var showingSideMenu: Bool
    
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                VStack {
                    header
                    // Tweets
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<20, id: \.self) { _ in
                                TweetRowView()
                            }
                        }
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
                    // After user travels away from menu, it is hidden offscreen to ensure a HomeTab reset
                    .onDisappear {
                        showingSideMenu = false
                    }
            }
            .toolbar(showingSideMenu ? .hidden : .automatic)
            .toolbar {
                // Profile picture, side menu reveal
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            showingSideMenu.toggle()
                        }
                    } label: {
                    if let profilePhoto = viewModel.currentUser?.profilePhotoUrl {
                            KFImage(URL(string: profilePhoto))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                                .padding(.bottom, 5)
                                
                        } else {
                            Circle()
                                .frame(width: 32)
                                .foregroundColor(.twitterBlue)
                                .padding(.leading, -4)
                        }
                    }
                }
                // Twitter logo
                ToolbarItem(placement: .principal) {
                    TwitterLogo()
                        .padding(8)
                        .opacity(showingSideMenu ? 0 : 1)
                }
            }
            // Maintains header shape
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(showingSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
    }
}

extension FeedView {
    var header: some View {
        ZStack{
            // Header background
            Rectangle().foregroundStyle(.ultraThinMaterial)
                .frame(height: 144)
                .offset(y: -100)
                .padding(.bottom, -100)
            // For You, Following
            HStack {
                ForEach(FeedType.allCases, id: \.rawValue) { feedType in
                    VStack {
                        Text(feedType.title)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(selectedFeed == feedType ? .primary : .secondary)
                            .padding(.horizontal, 66)
                        if selectedFeed == feedType {
                            Capsule()
                                .foregroundColor(Color.twitterBlue)
                                .frame(width: 62, height: 3)
                                .matchedGeometryEffect(id: "filter", in: animation)
                        } else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(width: 62, height: 3)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.selectedFeed = feedType
                        }
                    }
                }
            }
            .overlay(Divider().offset(y: 14))
            .offset(y: 8)
        }
    }
}
