//
//  SideMenuToolView.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import Foundation
import SwiftUI

enum SideMenuToolsViewModel: Int, CaseIterable {
    case twitterBlue
    case professionalTools
    case settingsAndSupport

    var title: String {
        switch self {
        case .twitterBlue: return "Twitter"
        case .professionalTools: return "Professional Tools"
        case .settingsAndSupport: return "Settings and support"
        }
    }
}
