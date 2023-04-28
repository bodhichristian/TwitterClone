//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/28/23.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
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
