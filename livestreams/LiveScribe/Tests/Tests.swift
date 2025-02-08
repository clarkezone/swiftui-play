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
    
    @Test func strong() {
        let uuid = UUID().uuidString
        let input = "**\(uuid)**"
        let output = "<p><strong>\(uuid)</strong></p>"
        let markdown = MarkdownParser(markdown: input)
        
        #expect(markdown.text == output)
    }
    
    @Test func emphasis() {
        let uuid = UUID().uuidString
        let input = "*\(uuid)*"
        let output = "<p><em>\(uuid)</em></p>"
        let markdown = MarkdownParser(markdown: input)
        
        #expect(markdown.text == output)
    }
    
    @Test func link() {
        let uuid = UUID().uuidString
        let input = "[\(uuid)](https://www/hackingwithswift.com/\(uuid)"
        let output = "<p><a href=\"https://www/hackingwithswift.com/\(uuid)>\(uuid)</a></p>"
        let markdown = MarkdownParser(markdown: input)
        
        #expect(markdown.text == output)
    }

}
