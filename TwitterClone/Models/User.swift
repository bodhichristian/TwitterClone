//
//  User.swift
//  TwitterClone
//
//  Created by christian on 4/26/23.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let name: String
    let phoneNumber: String
    let profilePhotoUrl: String?
    let profileBannerImageUrl: String?
    
    let bio: String?
    let location: String?
    let website: String?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id  }
    
    // Example User for previews
    static let example = User(
        username: "enygma",
        email: "theriddler@dc.com",
        name: "The Riddler",
        phoneNumber: "999-999-9999",
        profilePhotoUrl: "https://m0vie.files.wordpress.com/2010/08/riddler.jpg",
        profileBannerImageUrl: nil,
        bio: "For if knowledge is power, then a god am I! Was that over the top? I can never tell.",
        location: "Gotham",
        website: "www.theriddler.com"
    )
    // Empty User for missing User objects
    static let empty = User(
        username: "",
        email: "",
        name: "",
        phoneNumber: "",
        profilePhotoUrl: nil,
        profileBannerImageUrl: nil,
        bio: "" ,
        location: "Nowhere",
        website: ""
    )
}

