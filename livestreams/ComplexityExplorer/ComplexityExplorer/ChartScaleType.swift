//
//  ChartScaleType.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import Charts

enum ChartScaleType {
    case linear
    case logarithmic
    
    var chartsType: ScaleType {
        switch self {
        case .linear: .linear
        case .logarithmic: .symmetricLog
        }
    }
}
