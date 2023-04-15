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
            .colorInvert()
            .colorMultiply(.twitterBlue)
            .frame(width: 60)
    }
}

struct TwitterBlueB_Previews: PreviewProvider {
    static var previews: some View {
        TwitterBlueB()
    }
}
