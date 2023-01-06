//
//  TodoController.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import Foundation

class TodoController {
    

    static let shared = TodoController()
    
    let model = TodoModel()
    
    var homeDelegate: TodoHomeDelgate?
    var addDelegate: TodoAddDelegate?
    var detailDelegate: TodoDetailDelegate?
    var editDelegate: TodoEditDelegate?
    
    func selecTodo(index: Int, todo: TodoEntity) {
        
        model.selectTodo(index: index, todo: todo)
    }
    

    func getTodo() {
        
        model.loadTodo()
        homeDelegate?.todo(todosUpdated: model.todos)
    }
    
    func addTodo(title: String) {
        
        if let todo = model.addTodo(title: title) {
            addDelegate?.todo(todoCreated: todo)
        } else {
            addDelegate?.todo(todoCreateError: "No se pudo agregar el nuevo Todo")
        }
    }
    
    func updateTodoTitle(title: String) {
        
        if let index = model.todoSelectedIndex {
            if let todo = model.updateTodoTitle(index: index, title: title) {
                homeDelegate?.todo(todosUpdated: todo)
                detailDelegate?.todo(todoUpdated: todo)
                editDelegate?.todo(todoEdited: todo)
            } else {
                editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
            }
        } else {
            editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
        }
    }
    
    func updateTodoCheck(checked: Bool) {
        
        if let index = model.todoSelectedIndex {
            if let todo = model.updateTodoTitle(index: index, title: title) {
                homeDelegate?.todo(todosUpdated: todo)
                detailDelegate?.todo(todoUpdated: todo)
                editDelegate?.todo(todoEdited: todo)
            } else {
                editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
            }
        } else {
            editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
        }
        
    }
    
    func deleteTodo() {
        
        if let index = model.todoSelectedIndex {
            if let todo = model.deleteTodo(index: index) {
                homeDelegate?.todo(todosUpdated: model.todos)
                detailDelegate?.todo(todoUpdated: model.todos)
                editDelegate?.todo(todoEdited: todo)
            } else {
                editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
            }
        } else {
            editDelegate?.todo(todoEditError: "No se pudo editar el Todo")
        }
        
    }
}
