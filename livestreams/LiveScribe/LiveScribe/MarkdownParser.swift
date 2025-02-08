//
//  MarkdownParser.swift
//  LiveScribe
//
//  Created by James Clarke on 2/8/25.
//

import Foundation
import Markdown

struct MarkdownParser: MarkupVisitor {
    var text = ""
    
    init(markdown: String) {
        let document = Document(parsing: markdown)
        text = visit(document)
    }
    
    mutating func defaultVisit(_ markup: any Markup) -> String {
        var result = ""
        
        for child in markup.children {
            result += visit(child)
        }
        
        return result
    }
    
    func visitText(_ text: Text) -> String {
        text.plainText
    }
    
    mutating func visitParagraph(_ paragraph: Paragraph) -> String {
        var result = "<p>"
        for child in paragraph.children {
            result += visit(child)
        }
        result += "</p>"
        return result
    }
}
