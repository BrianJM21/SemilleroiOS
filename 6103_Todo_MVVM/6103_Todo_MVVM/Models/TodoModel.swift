//
//  TodoModel.swift
//  6103_Todo_MVVM
//
//  Created by User on 09/01/23.
//

import Foundation
import CoreData
import Combine

class TodoModel {
    
    static let shared = TodoModel()
    
    var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores { _, error in
            
            if let error = error {
                fatalError("No se pudo cargar el contenedor")
            }
        }
        return container
    }()
    
    @Published var todos: [TodoEntity] = []
    
    @Published var todoAdded: (sessionId: Int, todo: TodoEntity?) = (0, nil)
    
    func loadTodos() {
        
        let context = self.container.viewContext
        
        let request = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(request) {
            
            self.todos = todos
        }
    }
    
    func saveTodos(todos: [TodoEntity]) -> Bool {
        
        let context = self.container.viewContext
        
        for todo in todos {
            
            if todo.managedObjectContext != context {
                
                return false
            }
        }
                
        do {
            try context.save()
            return true
        } catch {
            
            context.rollback()
            return false
        }
    }
    
    func addTodo(sessionId: Int, title: String) {
        
        let context = self.container.viewContext
        
        let todo = TodoEntity(context: context)
        
        do {
            
            try context.save()
            self.loadTodos()
            self.todoAdded = (sessionId, todo)
        } catch {
            
            context.rollback()
            self.todoAdded = (sessionId, nil)
        }
    }
}
