//
//  SimpleWebView.swift
//  LiveScribe
//
//  Created by James Clarke on 2/8/25.
//

import SwiftUI
import WebKit

struct SimpleWebView: NSViewRepresentable {
    let wv = WKWebView()
    @State var content: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        wv.loadHTMLString(content, baseURL: nil)
       return wv
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        wv.loadHTMLString(content, baseURL: nil)
    }
}

#Preview {
    SimpleWebView(content: "test")
}
