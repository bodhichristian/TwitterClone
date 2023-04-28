//
//  ContentView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        // If no user is logged in
        if viewModel.userSession == nil {
            // Show Log in/Sign up options
            SignedOutView() 
        } else {
            // Otherwise, present MainTabView
            ZStack(alignment: .topLeading){
                MainTabView()
                    .environmentObject(viewModel)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
