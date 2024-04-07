//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ron Lane on 4/4/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
}
