//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Ron Lane on 4/4/24.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered     = "As Entered"
    case alphabetical  = "A-Z"
    case chronological = "Date"
    case completed     = "Not Done"
}

struct sortedToDoList: View {
    @Query var toDos: [ToDo]
    @Environment(\.modelContext) var modelContext
    
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _toDos = Query()
        case .alphabetical:
            _toDos = Query(sort: \.item, animation: .default)
        case .chronological:
            _toDos = Query(sort: \.dueDate)
        case .completed:
            _toDos = Query(filter: #Predicate { $0.isCompleted == false })
        }
    }
    
    var body: some View {
        List {
            ForEach(toDos) { toDo in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                            }
                        
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                    }
                    .font(.title2)
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        if toDo.reminderIsOn {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", role: .destructive) {
                        modelContext.delete(toDo)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            sortedToDoList(sortSelection: sortSelection)
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $sortSelection) {
                        ForEach(SortOption.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
