//
//  ContentView.swift
//  LiveScribe
//
//  Created by James Clarke on 2/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    var body: some View {
        TextEditor(text: $input)
        SimpleWebView()
    }
}

#Preview {
    ContentView()
}
