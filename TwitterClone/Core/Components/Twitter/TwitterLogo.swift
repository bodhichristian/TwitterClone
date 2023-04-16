//
//  TwitterLogo.swift
//  TwitterClone
//
//  Created by christian on 4/15/23.
//

import SwiftUI

struct TwitterLogo: View {
    var body: some View {
        Image("twitterLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 36)
    }
}

struct TwitterLogo_Previews: PreviewProvider {
    static var previews: some View {
        TwitterLogo()
    }
}
