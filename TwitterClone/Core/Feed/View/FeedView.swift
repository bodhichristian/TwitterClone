//
//  FeedView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var feedVM = FeedViewModel()
    
    @Binding var showingSideMenu: Bool
    @State private var selectedFeed: FeedType = .forYou
    @Namespace var animation // For animating blue bar in tweetFilter
    
    var body: some View {
        
        VStack {
            header
            feed
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
            Rectangle().foregroundStyle(.clear)
                .frame(height: 144)
                .offset(y: -100)
                .padding(.bottom, -100)
            
            VStack {
                // Header top row
                HStack {
                    // Profile Photo
                    Button {
                        // Display SideMenuView
                        withAnimation{
                            showingSideMenu = true
                        }
                    } label: {
                        // If current user has a profile image
                        if let profilePhoto = authVM.currentUser?.profilePhotoUrl {
                            // Fetch image
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
                    
                    Spacer()
                    
                    TwitterLogo()
                        .opacity(showingSideMenu ? 0 : 1)
                    
                    Spacer()
                    
                    // Placeholder to match header in ExploreView
                    Circle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                }
                .padding(.horizontal)
                
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
        .padding(.bottom, 10)
    }
    
    var feed: some View {
        // Tweets
        ScrollView {
            LazyVStack {
                ForEach(feedVM.feed) { tweet in
                    NavigationLink {
                        ProfileView(user: tweet.user ?? User.empty)
                    } label: {
                        TweetRowView(tweet: tweet)
                    }
                    .buttonStyle(PlainButtonStyle())                }
            }
        }
    }
}
