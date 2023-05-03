//
//  ExploreView.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Kingfisher

struct ExploreView: View {
    @ObservedObject var exploreVM: ExploreViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @Binding var showingSideMenu: Bool
        
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(exploreVM.searchableUsers) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        withAnimation {
//                            showingSideMenu.toggle()
//                        }
//                    } label: {
//                        
//                        Circle()
//                            .frame(width: 32)
//                            .padding(.leading, -4)
//                    }
//                }
//                ToolbarItem(placement: .principal) {
//                    SearchBar(text: $exploreVM.searchText)
//                    
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "gear")
//                    }
//                    .tint(.primary)
//                }
//            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(exploreVM: ExploreViewModel(), showingSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
