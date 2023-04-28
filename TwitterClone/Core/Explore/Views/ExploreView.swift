//
//  ExploreView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0...25, id: \.self) { _ in
                            NavigationLink {
                                ProfileView(user: User.example)
                            } label: {
                                UserRowView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
            ExploreView()
    }
}
