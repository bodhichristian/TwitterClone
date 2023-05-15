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
    
    
    
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id  }
    
    static let example = User(username: "enygma", email: "theriddler@dc.com", name: "The Riddler", phoneNumber: "999-999-9999", profilePhotoUrl: nil)
    static let empty = User(username: "", email: "", name: "", phoneNumber: "", profilePhotoUrl: nil)
}

