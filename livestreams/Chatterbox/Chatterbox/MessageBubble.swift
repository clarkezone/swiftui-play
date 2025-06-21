//
//  MessageBubble.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        let alignment = message.isAI ? Alignment.leading : .trailing
        Text(message.text)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundStyle(message.isAI ? Color.primary: .white)
            .background(message.isAI ? Color.blue : Color.gray)
            .clipShape(.rect(cornerRadius: 16))
//            .containerRelativeFrame(.horizontal, alignment: alignment) {
//                size, axis in
//                
//            }
//            .transition(.move(ed))
            
            
    }
}

//#Preview {
//    MessageBubble()
//}
