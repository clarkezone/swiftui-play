//
//  ContentView.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var client = APIClient(apiKey: "")
    @State private var messages: [Message] = []
    @State private var messageText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(messages, content: MessageBubble.init)
                            
                        }
                        .padding(.horizontal)
                    }
                    .defaultScrollAnchor(.bottom)
                    .onChange(of: messages) {
                        Task {
                            try await Task.sleep(for: .seconds(0.2))
                            proxy.scrollTo(messages.last?.id)
                        }
                    }
                    
                TextField("Write somthing", text: $messageText).onSubmit(
                    sendMessage)
                }
            }
        }
        .padding()
    }
    
    func sendMessage() {
        let prompt = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard prompt.isEmpty == false else { return }
        
        messageText = ""
        
        withAnimation {
            messages.append(Message(text: prompt, isAI: false))
        }
       
        Task {
            let lastMessage: String? = messages.last(where: { $0.isAI })?.id ?? nil
            let response = try await client.generatetext(from: prompt, instructions: "You are a chatterbox, a bot for chatting only.  You are addressing minors", previousResponse: lastMessage ?? "" )
            
            let newMessage = Message(id: response.id, text: response.message, isAI: true )
            
            withAnimation {
                messages.append(newMessage)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
