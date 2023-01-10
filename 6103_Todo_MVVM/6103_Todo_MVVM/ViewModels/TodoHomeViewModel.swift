//
//  TodoHomeViewModel.swift
//  6103_Todo_MVVM
//
//  Created by User on 09/01/23.
//

import Foundation
import Combine

class TodoHomeViewModel {
    
    @Published var todos: [TodoEntity] = []
    
    @Published var todoSelected: TodoEntity?
    
    var todoSubscriber: AnyCancellable?
    
    init() {
        
        self.todoSubscriber = TodoModel.shared.$todos.dropFirst().sink {
            
            todos in
            self.todos = todos
        }
    }
    
    deinit {
        
        self.todoSubscriber?.cancel()
        self.todoSubscriber = nil
    }
    
    func loadTodos() {
        
        TodoModel.shared.loadTodos()
    }
    
    func selecTodo(index: Int) {
        
        self.todoSelected = todos[index]
    }
}
