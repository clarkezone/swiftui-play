//
//  ControlsView.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import SwiftUI

struct ControlsView: View {
    @Binding var inputSize: Double
    @Binding var yType: ChartScaleType
    
    var body: some View {
        HStack {
            LabeledContent {
                Slider(value: $inputSize, in: 2...32, step: 1)
            } label: {
                Text("Input size: \(Int(inputSize))")
                    .frame(minWidth: 100)
            }
            
            Picker("Chart Type", selection: $yType) {
                Text("linear").tag(ChartScaleType.linear)
                Text("Logartihmic").tag(ChartScaleType.logarithmic)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .fixedSize()
        }.padding()
    }
}

#Preview {
    ControlsView(inputSize: .constant(2), yType: .constant(.linear))
}
