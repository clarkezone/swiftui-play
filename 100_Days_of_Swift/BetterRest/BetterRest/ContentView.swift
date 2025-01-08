//
//  ContentView.swift
//  BetterRest
//
//  Created by James Clarke on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("Sleep amount \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp, in: exampleDates(), displayedComponents: .hourAndMinute).labelsHidden()
        }
        .padding()
    }
    
    func exampleDates() -> ClosedRange<Date> {
        let tommorow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tommorow
        return range
    }
}

#Preview {
    ContentView()
}
