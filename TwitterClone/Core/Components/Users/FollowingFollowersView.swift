//
//  FollowingFollowersView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct FollowingFollowersView: View {
    let following: Int
    let followers: Int
    
    var body: some View {
        // Following/Followers Count
        HStack {
            // Following
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(following)")
                    .bold()
                Text("Following")
                    .foregroundColor(.primary.opacity((0.6)))
            }
            // Followers
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(followers)")
                    .bold()
                Text("Followers")
                    .foregroundColor(.primary.opacity((0.6)))
            }
        }
        .font(.caption2)
    }
}

struct FollowingFollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingFollowersView(following: 275, followers: 825)
    }
}
