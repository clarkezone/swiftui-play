//
//  Tests.swift
//  Tests
//
//  Created by James Clarke on 2/8/25.
//

import Testing
import Foundation
@testable import LiveScribe

struct LiveScribeTests {
    @Test func empty() {
        let markdown = MarkdownParser(markdown: "")
        #expect(markdown.text == "")
    }
    
    @Test func singleParagraph() {
        let uuid = UUID().uuidString
        let markdown = MarkdownParser(markdown: uuid)
        let output = "<p>\(uuid)</p>"
        #expect(markdown.text == output)
    }
    
    @Test func multipleParagraphs() {
        
        let uuid = UUID().uuidString
        let input = Array(repeating: uuid, count: 3).joined(separator: "\n\n")
        let output = Array(repeating: "<p>\(uuid)</p>", count:3).joined()
        let markdown = MarkdownParser(markdown: input)
        #expect(markdown.text == output)

    }

}
