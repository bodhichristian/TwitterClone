//
//  ExploreSettingsView.swift
//  TwitterClone
//
//  Created by christian on 4/28/23.
//

import SwiftUI

struct ExploreSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Explore Settings View")
        
        Button {
            presentationMode.wrappedValue.dismiss()
        } label : {
            Text("Go back")
        }
    }
}

struct ExploreSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSettingsView()
    }
}
