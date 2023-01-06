//
//  TodoModel.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import Foundation
import CoreData

class TodoModel {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor.. \(error)")
            }
        }
        
        return container
    }()
    
    var todos: [TodoEntity] = []
    
    var todoSelected: TodoEntity?
    
    var todoSelectedIndex: Int?
    
    func selectTodo(index: Int, todo: TodoEntity) {
        
        self.todoSelected = todo
        self.todoSelectedIndex = indexf
    }
    
    func loadTodo() {
        
        let context = self.persistentContainer.viewContext
        
        let requestTodos = TodoEntity.fetchRequest()
        
        if let todos = try? context.fetch(requestTodos) {
            
            self.todos = todos
        }
    }
    
    func getTodo(index: Int) -> TodoEntity? {
        
        guard index >= 0 && index < todos.count
        else { return nil }
        
        return todos[index]
    }
    
    func addTodo(title: String) -> TodoEntity? {
        
        let context = persistentContainer.viewContext
        
        let todo = TodoEntity(context: context)
        
        todo.id = Int64.random(in: 1...1_000_000)
        todo.title = title
        todo.checked = false
        todo.createdAt = Date.now
        
        do {
            try context.save()
            self.loadTodo()
            return todo
        } catch {
            context.rollback()
            return nil
        }
    }
    
    func updateTodoTitle(index: Int, title: String) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.title = title
            todo.updatedAt = Date.now
            
            let context = persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodo()
                return todo
            } catch {
                context.rollback()
                return nil
            }
            
        }
        
        return nil
    }
    
    ///Actualizamos el checked de un ´todo´ y lo almacenamos en el *CoreData*
    func updateTodoCheck(index: Int, checked: Bool) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            todo.checked = checked
            todo.updatedAt = Date.now
            
            let context = persistentContainer.viewContext
            
            do {
                try context.save()
                self.loadTodo()
                return todo
            } catch {
                context.rollback()
                return nil
            }
        }
        
        return nil
    }
    
    ///Eliminamos un ´todo´ y guardamos el cambio en el *CoreData*
    func deleteTodo(index: Int) -> TodoEntity? {
        
        if let todo = self.getTodo(index: index) {
            
            let context = persistentContainer.viewContext
            
            context.delete(todo)
            
            do {
                try context.save()
                self.loadTodo()
                return todo
            } catch {
                context.rollback()
                return nil
            }
        }
        
        return nil
    }
    
}
