//
//  TwitterBlueB.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct TwitterBlueB: View {
    var body: some View {
        Image("twitterBlueB")
        
            .resizable()
            .scaledToFit()
        
            .frame(width: 60)
            .shadow(color: .twitterBlue, radius: 0.5, x: -2, y: 2)
    }
}

struct TwitterBlueB_Previews: PreviewProvider {
    static var previews: some View {
        TwitterBlueB()
    }
}
