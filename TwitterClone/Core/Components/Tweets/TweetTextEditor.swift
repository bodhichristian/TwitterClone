//
//  TweetTextEditor.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct TweetTextEditor: View {
    @Binding var tweetBody: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $tweetBody)
                .multilineTextAlignment(.leading)
                .padding(4)
                .font(.body)
            
            if tweetBody.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 12)
            }
        }
    }
}

struct TweetTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        TweetTextEditor(tweetBody: .constant(""), placeholder: "What's happening?")
    }
}
