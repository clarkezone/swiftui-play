//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by James Clarke on 12/16/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func LargeBlue() -> some View {
        modifier(LargeBlueFont())
    }
}

struct WaterMarked : ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermark(text: String) -> some View {
        modifier(WaterMarked(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content // trailing closure
    
    var body: some View {
        VStack {
            Text("Cool")
                .LargeBlue()
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) {
                        column in
                            content(row, column)
                    }
                }
                
            }
        }
    }
}

struct ContentView: View {
    @State private var useRedText = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Spacer()
            Button("Type") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(.yellow)
            Button("Toggle") {
                useRedText.toggle()
            }
            .foregroundStyle(useRedText ? .red : .yellow)
            .font(.title)
            Button("RahRoh") {
                
            }
            .modifier(Title())
            
            Button("RAHROH") {
                
            }
            .titleStyle()
            
            Button("RubyRubyRoo") {
                
            }
            .watermark(text: "Foo")
            GridStack(rows:5, columns: 3) { row, col in
                Text("Moon \(row) \(col)")
            }
        }
        .padding()
        .frame(width: 200, height: 200)
        .background(.red)
//        .blur(radius: 5)
    }
}

#Preview {
    ContentView()
}
