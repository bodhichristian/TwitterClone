//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/28/23.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    let service = UserService()
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let query = searchText.lowercased()
            
            return users.filter {
                $0.username.contains(query) ||
                $0.name.lowercased().contains(query)
            }
        }
    }
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchAllUsers { users in
            self.users = users
            print("DEBUG: Users: \(users)")
        }
    }
}
