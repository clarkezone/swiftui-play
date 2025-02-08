// First, add Realm to your project using Swift Package Manager
// Add this dependency to your Package.swift:
// .package(url: "https://github.com/realm/realm-swift.git", .upToNextMajor(from: "10.45.0"))

// Task.swift
import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var completed: Bool
    
    convenience init(title: String) {
        self.init()
        self.id = ObjectId.generate()
        self.title = title
        self.completed = false
    }
}

// TasksView.swift
import SwiftUI
import RealmSwift

struct TasksView: View {
    @ObservedResults(Task.self) var tasks
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add") {
                        let task = Task(title: newTaskTitle)
                        $tasks.append(task)
                        newTaskTitle = ""
                    }
                    .disabled(newTaskTitle.isEmpty)
                }
                .padding()
                
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if let thawedTask = task.thaw(),
                               let realm = thawedTask.realm {
                                try? realm.write {
                                    thawedTask.completed.toggle()
                                }
                            }
                        }
                    }
                    .onDelete(perform: $tasks.remove)
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

// HelloWorldApp.swift
import SwiftUI
import RealmSwift

@main
struct HelloWorldApp: SwiftUI.App {
    init() {
        // Configure Realm for the app
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                // Handle any schema changes here
            })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    var body: some Scene {
        WindowGroup {
            TasksView()
        }
    }
}
