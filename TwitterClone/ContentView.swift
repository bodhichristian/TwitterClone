//
//  ContentView.swift
//  Versa
//
//  Created by christian on 4/13/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
        }
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
