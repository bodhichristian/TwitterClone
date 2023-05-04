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
   // @EnvironmentObject var viewModel: AuthViewModel
    let user: User
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @State private var showingEditProfilePhotoView = false
    
    @Namespace var animation // For animating blue bar in tweetFilter
    
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            editProfileButton
            aboutView
            tweetFilterBar
            tweetsView
            
            Spacer()
        }
        .sheet(isPresented: $showingEditProfilePhotoView) {
            EditProfilePhotoView()
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.example)
            .environmentObject(AuthViewModel())
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color.twitterBlue
                .ignoresSafeArea()
            
            // Back Arrow
            VStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    BackArrow()
                        .offset(x: 2, y: 10)
                }
                
                // Profile Picture
                ZStack {
                    if let profilePhoto = user.profilePhotoUrl {
                        KFImage(URL(string: profilePhoto))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 69)
                            .clipShape(Circle())
                            
                    } else {
                        Circle()
                            .foregroundColor(.black)
                    }

                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 3))
                        .foregroundColor(.white)
                        .frame(width: 72)
                }
                .onTapGesture {
                    showingEditProfilePhotoView = true
                }
                .offset(x: 16, y: 44)
            }
        }
        .frame(height: 112)
        .navigationBarBackButtonHidden(true)
    }
    
    var editProfileButton: some View {
        HStack {
            Spacer()
            
            Button {
                // Edit Profile Action
            } label: {
                Text("Edit Profile")
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
    
    var aboutView: some View {
        VStack(alignment: .leading, spacing: 2) {
            // ID Badge
            HStack(spacing: 4) {
                // Display Name
                Text(user.name)
                    .font(.title3).fontWeight(.semibold)
                    .padding(.top, 15)
                // Verified
                BlueCheck()
                    .offset(y: 8)
            }
            // @username
            Text("@\(user.username)")
                .font(.caption)
                .foregroundColor(.secondary)
            // Bio
            Text("For if knowledge is power, then a god am I! \nWas that over the top❓I can never tell.")
                .font(.subheadline)
                .padding(.top, 10)
                .padding(.bottom, 6)
            
            // Details
            HStack {
                // Location
                HStack(spacing: 2) {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Gotham, NY")
                    
                }
                // Website
                HStack(spacing: 2) {
                    Image(systemName: "link")
                    Text("www.theriddler.com")
                }
                // Tenure
                HStack(spacing: 2) {
                    Image(systemName: "calendar")
                    Text("Joined June 2012")
                }
            }
            .font(.caption)
            .foregroundColor(.primary.opacity((0.6)))

            // Following/Followers Count
            FollowingFollowersView(following: 666, followers: 999)
                .padding(.vertical, 12)
        }
        // Top VStack modifiers
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
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
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10, id: \.self) { _ in
                    TweetRowView(tweet: Tweet.example)
                }
            }
        }
    }
}
