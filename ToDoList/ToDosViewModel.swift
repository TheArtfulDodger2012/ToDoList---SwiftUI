//
//  ToDosViewModel.swift
//  ToDoList
//
//  Created by Ron Lane on 4/5/24.
//

import Foundation

class ToDosViewModel: ObservableObject {
    @Published var toDos: [ToDo] = []
    
}
