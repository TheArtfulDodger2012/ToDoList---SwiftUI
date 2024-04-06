//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Ron Lane on 4/4/24.
//

import SwiftUI

struct ToDoListView: View {
    @EnvironmentObject var toDosVM: ToDosViewModel

    @State private var sheetIsPresented = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(toDosVM.toDos) { toDo in
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                        
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                    }
                    .font(.title2)
                }
                .onDelete(perform: toDosVM.deleteToDo)
                .onMove  (perform: toDosVM.moveToDo)
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
//            .fullScreenCover(isPresented: $sheetIsPresented) {
//                DetailView(passedValue: "")
//            }
        }
    }
}

#Preview {
    ToDoListView()
        .environmentObject(ToDosViewModel())
}
