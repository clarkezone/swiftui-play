//
//  OpenAIResponse.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import Foundation

struct OpenAIResponse: Decodable {
    let id: String
    let output: [OpenAIMessage]
}

struct OpenAIMessage: Decodable {
    let content: [OpenAIMessageContent]
}

struct OpenAIMessageContent: Decodable {
    let text: String
}
