//
//  GrowthRate.swift
//  ComplexityExplorer
//
//  Created by James Clarke on 12/14/24.
//

import Foundation

struct GrowthRate: Hashable, Identifiable {
    var id: String
    var function: (Int) -> Double
    
    static var all: [GrowthRate] {
        [
            GrowthRate(id: "Linear", function: linearGrowth),
            GrowthRate(id: "Conatant", function: constantGrowth),
            GrowthRate(id: "Logarithmic", function: logarithmicGrowth),
            GrowthRate(id: "Linearithmic", function: linearithmicGrowth),
            GrowthRate(id: "Quadratic", function: quadraticGrowth),
            GrowthRate(id: "Cubic", function: cubicGrowth),
            GrowthRate(id: "Exponential", function: exponentialGrowth),
            GrowthRate(id: "Factorial", function: factorialGrowth),
        ]
    }
    
    static func ==(lhs: GrowthRate, rhs: GrowthRate) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
   
    //O(n)
    static func linearGrowth(_ n: Int) -> Double {
        Double(n)
    }
    
    //O(1)
    static func constantGrowth(_ n: Int) -> Double {
        1
    }
   
    //O(sqrt(n))
    static func squareRootGrowth(_ n: Int) -> Double {
        sqrt(Double(n))
    }
    
    //O(log(n))
    static func logarithmicGrowth(_ n: Int) -> Double {
        max(0, log2(Double(n)))
    }

    //O(n log(n))
    static func linearithmicGrowth(_ n: Int) -> Double {
        max(0, Double(n) * log2(Double(n)))
    }
    
    //O(n^2))
    static func quadraticGrowth(_ n: Int) -> Double {
        pow(Double(n), 2)
    }
    
    //O(n^3))
    static func cubicGrowth(_ n: Int) -> Double {
        pow(Double(n), 3)
    }
    
    //O(2^n))
    static func exponentialGrowth(_ n: Int) -> Double {
        pow(2, Double(n))
    }
    
    //O(n!))
    static func factorialGrowth(_ n: Int) -> Double {
        guard n > 0 else {return 1}
        return (1...n).map(Double.init).reduce(1, *)
    }
}
