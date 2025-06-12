//
//  SwiftShippedDataTestApp.swift
//  SwiftShippedDataTest
//
//  Created by James Clarke on 6/11/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftShippedDataTestApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
            do {
                guard let storeURL = Bundle.main.url(forResource: "output", withExtension: "store") else {
                    fatalError("Failed to find users.store")
                }

                let config = ModelConfiguration(url: storeURL)
                let config2 = ModelConfiguration(for: Aphorism.self)
                container = try ModelContainer(for: User.self, Aphorism.self, configurations: config, config2)
            } catch {
                fatalError("Failed to create model container: \(error)")
            }
        }
}
