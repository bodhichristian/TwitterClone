//
//  BlueCheck.swift
//  TwitterClone
//
//  Created by christian on 4/14/23.
//

import SwiftUI

struct BlueCheck: View {
    var body: some View {
        Image(systemName: "checkmark.seal.fill")
            .font(.caption)
            .foregroundColor(.twitterBlue)
    }
}

struct BlueCheck_Previews: PreviewProvider {
    static var previews: some View {
        BlueCheck()
    }
}
