//
//  ContentView.swift
//  SwiftShippedDataTest
//
//  Created by James Clarke on 6/11/25.
//

import SwiftUI
import SwiftData

@Model
class User {
    var name: String

    init(name: String) {
        self.name = name
    }
}

@Model
class Aphorism {
    var name: String

    init(name: String) {
        self.name = name
    }
}

struct ContentView: View {
    @Query var users: [User]
    @Query var aphorisms: [Aphorism]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        Button("Add User") {
            let newOne = Aphorism(name: "Needs not approval")
            modelContext.insert(newOne)
            do {
                try modelContext.save()
            } catch {
               print("Error saving: \(error)")
            }
        }
         NavigationStack {
            List(aphorisms) { aphorism in
                Text(aphorism.name)
            }
            .navigationTitle("Users")
        } 
        
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    ContentView()
}
