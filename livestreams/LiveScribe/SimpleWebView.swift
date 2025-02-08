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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        wv.loadHTMLString("hello", baseURL: nil)
       return wv
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
    }
}

#Preview {
    SimpleWebView()
}
