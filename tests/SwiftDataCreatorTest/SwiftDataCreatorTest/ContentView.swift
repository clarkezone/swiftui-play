//
//  ContentView.swift
//  SwiftDataCreatorTest
//
//  Created by James Clarke on 6/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Create Data") { create() }
        }
    }

    func create() {
        // Load our data model
        let container = NSPersistentContainer(name: "Model")

        // Write to a specific store filename, for easier deletion and copying.
        let storeURL = URL.documentsDirectory.appending(path: "users.store")

        if let description = container.persistentStoreDescriptions.first {
            // Delete all existing data.
            try? FileManager.default.removeItem(at: storeURL)

            // Make Core Data write to our new store URL.
            description.url = storeURL

            // Force WAL mode off.
            description.setValue("DELETE" as NSObject, forPragmaNamed: "journal_mode")
        }

        container.loadPersistentStores { description, error in
            do {
                // Add all your pre-fill data here.
                for i in 1...10_000 {
                    let user = User(context: container.viewContext)
                    user.name = "User \(i)"
                    container.viewContext.insert(user)
                }

                // Ensure all our changes are fully saved.
                try container.viewContext.save()

                // Adjust this to the actual location where you want the file to be saved.
                let destination = URL.documentsDirectory.appending(path: "output.store")
                try FileManager.default.copyItem(at: storeURL, to: destination)
            } catch {
                print("Failed to create data: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
