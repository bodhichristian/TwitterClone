//
//  ContentView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showingSideMenu = false

    var body: some View {
            ZStack(alignment: .topLeading) {
                MainTabView()
                SideMenuView()
                    .frame(width: 300)

                    .ignoresSafeArea()
                    .offset(x: showingSideMenu ? 0 : -300)
            }
            
         
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
