//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Ron Lane on 4/4/24.
//

import SwiftUI

struct ToDoListView: View {
    @State private var sheetIsPresented = false

    var toDos = [
        "Learn Swift",
        "Build Apps", 
        "Change the World",
        "Bring the Awesome",
        "Take a Vacation"
        ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView(passedValue: toDo)
                    } label: {
                        Text(toDo)
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
                DetailView(passedValue: "")
            }
//            .fullScreenCover(isPresented: $sheetIsPresented) {
//                DetailView(passedValue: "")
//            }
        }
    }
}

#Preview {
    ToDoListView()
}
