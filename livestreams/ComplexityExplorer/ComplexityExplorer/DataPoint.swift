//
//  DataPoint.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import Foundation

struct DataPoint: Identifiable {
    let id = UUID()
    var x: Int
    var y: Double
    let rate: String
}
