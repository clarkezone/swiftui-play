//
//  TypingIndicator.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import SwiftUI

struct TypingIndicator: View {
    @State private var animatingDots = false
    
    var body: some View {
        Image(systemName: "ellipsis")
            .symbolEffect(.variableColor, isActive: animatingDots)
            .font(.title)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            .clipShape(.rect(cornerRadius: 16))
            .onAppear {
                withAnimation(.linear.repeatForever()) {
                    animatingDots = true
                }
            }
    }
}

#Preview {
    TypingIndicator()
}
