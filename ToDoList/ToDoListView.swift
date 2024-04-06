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
                    NavigationLink {
                        DetailView(toDo: ToDo())
                    } label: {
                        Text(toDo.item)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
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
                    DetailView(toDo: ToDo(), newToDo: true)
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
