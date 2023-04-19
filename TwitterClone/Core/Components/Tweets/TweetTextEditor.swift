//
//  TweetTextEditor.swift
//  TwitterClone
//
//  Created by christian on 4/19/23.
//

import SwiftUI

struct TweetTextEditor: View {
    @Binding var tweetText: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $tweetText)
                .multilineTextAlignment(.leading)
                .padding(4)
                .font(.body)
            
            if tweetText.isEmpty {
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
        TweetTextEditor(tweetText: .constant(""), placeholder: "What's happening?")
    }
}
