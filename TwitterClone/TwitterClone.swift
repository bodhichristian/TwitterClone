//
//  VersaApp.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Firebase

@main
struct TwitterClone: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView{
                //ContentView()
                ProfileView()
            }
            .environmentObject(viewModel)
        }
    }
}
