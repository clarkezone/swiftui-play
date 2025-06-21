//
//  MessageInputView.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import SwiftUI

struct MessageInputView: View {
    @FocusState private var isInputFocused: Bool
    @Binding var messageText: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("Write something", text: $messageText, axis: .vertical)
                .focused($isInputFocused)
                .textFieldStyle(.roundedBorder)
            Button("Send Message", systemImage: "arrow.up.circle.fill", action: onSend)
                .labelStyle(.iconOnly)
                .font(.title)
                .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .onAppear {
            isInputFocused = true
        }
        
    }
}

//#Preview {
//    MessageInputView()
//}
