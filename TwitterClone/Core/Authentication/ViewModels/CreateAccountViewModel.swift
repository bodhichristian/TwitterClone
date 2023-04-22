//
//  CreateAccountViewModel.swift
//  TwitterClone
//
//  Created by christian on 4/22/23.
//

import Foundation

enum CreateAccountViewModel: Int, CaseIterable {
    case name
    case email
    case phoneNumber
    case username
    case password
    case passwordCheck

    var title: String {
        switch self {
        case .name: return "Name"
        case .email: return "Email"
        case .phoneNumber: return "Phone number"
        case .username: return "Username"
        case .password: return "Password"
        case .passwordCheck: return "Re-enter password"
        }
    }
    
    var imageName: String {
        switch self {
        case .name: return "person"
        case .email: return "enveloope"
        case .phoneNumber: return "phone"
        case .username: return "at"
        case .password: return "lock.shield"
        case .passwordCheck: return "lock.shield.fill"
        }
    }
}

