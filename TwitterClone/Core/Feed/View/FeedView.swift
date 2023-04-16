//
//  FeedView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct FeedView: View {
    @Namespace var animation // For animating blue bar in tweetFilter
    @State private var selectedFeed: FeedType = .forYou
    
    var body: some View {
        NavigationView {
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
            .toolbar {
                // Profile picture
                ToolbarItem(placement: .navigationBarLeading) {
                    Circle()
                        .frame(width: 32)
                }
                // Twitter logo
                ToolbarItem(placement: .principal) {
                    TwitterLogo()
                        .padding(8)
                }
            }
            // Maintains header shape
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
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
