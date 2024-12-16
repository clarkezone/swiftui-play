//
//  ContentView.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItems = Set<GrowthRate>()
    @State private var inputSize = 4.0
    @State private var yType = ChartScaleType.linear
    @State private var showingHelp = true
    
    var body: some View {
        NavigationSplitView {
            List(GrowthRate.all, id: \.self, selection: $selectedItems) {
                item in
                Text(item.id)
            }
        } detail: {
            VStack {
                ChartView(selectedItems: selectedItems, inputSize: inputSize, yType: yType)
                
                ControlsView(inputSize: $inputSize, yType: $yType)
            }
        }
        .inspector(isPresented: $showingHelp, content: {
            HelpView(selectedItem: selectedItems, showingHelp: $showingHelp)
        })
            
        .onAppear {
            selectedItems = [GrowthRate.all[0]]
        }
    }
}

#Preview {
    ContentView()
}
