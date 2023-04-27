//
//  User.swift
//  TwitterClone
//
//  Created by christian on 4/26/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let username: String
    let email: String
    let name: String
    let phoneNumber: String
    let profilePhotoUrl: String?
}

