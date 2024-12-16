//
//  ChartView.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import Charts
import SwiftUI

struct ChartView: View {
    @State private var selectedX: Int?
    
    var inputSize: Double
    var dataPoints: [DataPoint]
    var yPeak: Double
    var yType: ChartScaleType
    
    var body: some View {
        Chart(dataPoints) {
            point in
            LineMark(x: .value("x", point.x), y: .value("y", point.y),
                     series: .value("Rate", point.rate)
            )
            .foregroundStyle(by: .value("Rate", point.rate))
            .interpolationMethod(.monotone)
            
            if selectedX == point.x {
                PointMark(x: .value("X", point.x), y: .value("Y", point.y))
                    .foregroundStyle(by: .value("RAte", point.rate))
                    .annotation(position: .top) {
                        Text(point.y.formatted(
                            .number.precision( .fractionLength(0...2))))
                            .padding(8)
                            .font(.title2.bold())
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                    }
            }
        }
        .chartXSelection(value: $selectedX)
        .chartXScale(domain: 0...inputSize)
        .chartYScale(domain: 0...yPeak, type: yType.chartsType)
        .chartYAxis {
            AxisMarks(preset: .automatic) { value in
                AxisGridLine()
                
                AxisValueLabel {
                    let value = value.as(Decimal.self) ?? 0
                    
                    Text("\(value.formatted(.number))")
                        .frame(minWidth: 30, maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
    }
    
    init(selectedItems: Set<GrowthRate>, inputSize: Double, yType: ChartScaleType) {
        self.inputSize = inputSize
        self.yType = yType
        
        dataPoints = selectedItems.flatMap({ rate in
            (0...Int(inputSize)).map {
                x in
                DataPoint(x: x, y: rate.function(x), rate: rate.id)
            }
        })
        
        yPeak = dataPoints.max {
            $0.y < $1.y}?.y ?? 2
        if yPeak.isNaN {yPeak = 2}
    }
}

#Preview {
    ChartView(selectedItems: Set(GrowthRate.all), inputSize: 3, yType: .linear)
}
