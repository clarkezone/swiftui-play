//
//  Message.swift
//  Chatterbox
//
//  Created by James Clarke on 6/21/25.
//

import Foundation

struct Message: Equatable, Identifiable {
    var id: String = UUID().uuidString
    var text: String
    var isAI: Bool
    var timestable = Date.now
}
