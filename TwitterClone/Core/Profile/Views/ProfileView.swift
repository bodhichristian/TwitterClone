//
//  ProfileView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @State private var showingEditProfileView = false
    @State private var showingEditProfilePhotoView = false
    @Namespace var animation // For animating blue bar in tweetFilter
        
    init(user: User ) {
        self.viewModel = ProfileViewModel(user: user)
        self.viewModel.fetchUserTweets()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView // Banner image, profile photo
            
            actionButton // Edit Profile or Follow Button
            
            aboutView // Name, @username, bio, profile info, network
            
            tweetFilterView // Tweet filter selection
            
            tweetsView // Feed of filtered tweets
            
            Spacer()
        }
        .sheet(isPresented: $showingEditProfileView) {
            EditProfileView()
        }
        .sheet(isPresented: $showingEditProfilePhotoView) {
            EditProfilePhotoView()
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.example)
    }
}

extension ProfileView {
    // Banner image, profile photo
    private var headerView: some View {
        ZStack(alignment: .topLeading) {
            // Background color
            Color.twitterBlue
                .ignoresSafeArea()
            
            VStack { // Display banner image if available
                if let profileBannerImageUrl = viewModel.user.profileBannerImageUrl {
                    KFImage(URL(string: profileBannerImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 84)
                        .offset(y: 20)
                        .ignoresSafeArea()
                    
                }
                
                Spacer()
            }
            
            VStack { // Back Arrow
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    BackArrow()
                }
                
                ZStack { // Display profile photo if available
                    if let profilePhoto = viewModel.user.profilePhotoUrl {
                        KFImage(URL(string: profilePhoto))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 69)
                            .clipShape(Circle())
                            
                    } else { // If no photo is available, display placeholder
                        Circle()
                            .foregroundColor(.black)
                    }

                    Circle() // Photo border
                        .stroke(style: StrokeStyle(lineWidth: 3))
                        .foregroundColor(.white)
                        .frame(width: 72)
                }
                .onTapGesture { // Display EditProfileView
                    showingEditProfilePhotoView = true
                }
                .offset(x: 16, y: 44)
            }
        }
        .frame(height: 112)
        .navigationBarBackButtonHidden(true) // Hide native naviagtion
    }
    // Edit Profile or Follow Button
    private var actionButton: some View {
        HStack {
            Spacer()
            
            Button {
                // If viewing own profile
                if viewModel.user.isCurrentUser {
                    showingEditProfileView = true
                } else { // If viewing any other user's profile.
                    // Handle follow/unfollow actions
                }
                
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .frame(width: 96, height: 28)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.5), lineWidth: 0.75))
                
            }
        }
        .padding(.trailing)
        .padding(.top, 4)
    }
    // Name, @username, bio, profile info, network
    private var aboutView: some View {
        VStack(alignment: .leading, spacing: 2) {
            // ID Badge
            HStack(spacing: 4) {
                // Display Name
                Text(viewModel.user.name)
                    .font(.title3).fontWeight(.semibold)
                    .padding(.top, 15)
                // Verified
                BlueCheck()
                    .offset(y: 8)
            }
            // @username
            Text("@\(viewModel.user.username)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            
            // Bio
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.subheadline)
                    .padding(.top, 10)
            }
            
            // Details
            HStack {
                // Location
                if let location = viewModel.user.location {
                    HStack(spacing: 2) {
                        Image(systemName: "mappin.and.ellipse")
                        Text(location)
                        
                    }
                }
                // Website
                if let website = viewModel.user.website {
                    HStack(spacing: 2) {
                        Image(systemName: "link")
                        Link(website, destination: URL(string: website) ?? URL(string: "www.google.com")!)
                            .foregroundColor(.twitterBlue)
                    }
                }
                // Tenure
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                    Text("Joined June 2012")
                }
            }
            .font(.caption)
            .foregroundColor(.primary.opacity((0.6)))
            .padding(.top, 6)

            // Following/Followers Count
            FollowingFollowersView(following: 666, followers: 999)
                .padding(.vertical, 12)
        }
        // Top VStack modifiers
        .padding(.horizontal)
    }
    // Tweet filter selection
    private var tweetFilterView: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { tweetFilter in
                VStack {
                    Text(tweetFilter.title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(selectedFilter == tweetFilter ? .primary : .secondary)
                    
                    if selectedFilter == tweetFilter {
                        Capsule()
                            .foregroundColor(Color.twitterBlue)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.selectedFilter = tweetFilter
                    }
                }
            }
        }
        .overlay(Divider().offset(y: 14))
    }
    // Feed of filtered tweets
    private var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tweets(forFilter: self.selectedFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                }
            }
        }
    }
}
