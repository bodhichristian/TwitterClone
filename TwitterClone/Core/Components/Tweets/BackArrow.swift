//
//  BackArrow.swift
//  TwitterClone
//
//  Created by christian on 4/13/23.
//

import SwiftUI

struct BackArrow: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 34)
                .foregroundStyle(.black.opacity(0.3))
            Image(systemName: "arrow.left")
                .foregroundColor(.white).fontWeight(.medium)
        }
    }
}

struct BackArrow_Previews: PreviewProvider {
    static var previews: some View {
        BackArrow()
    }
}
