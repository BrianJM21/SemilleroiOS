import UIKit

struct Todo {
    
    let title: String
    let checked: Bool
}

class TodoModel {
    
    var todos: [Todo] = []
    
}

protocol TodoViewDelegate {
    
    func todo(todoAdded todo: Todo)
}

class TodoController {
    
    static let shared = TodoController()
    
    var model = TodoModel()
    
    var todoViewDelegate: TodoViewDelegate?
    
    func addTodo(title: String) {
        
        print("Creando nuevo Todo")
        
        let todo = Todo(title: title, checked: false)
        
        print("Agregando nuevo Todo al modelo")
        
        model.todos.append(todo)
        
        print("Notificando a la vista que el Todo ha sido creado")
        
        self.todoViewDelegate?.todo(todoAdded: todo)
    }
}

class TodoView {
    
    init() {
        
        TodoController.shared.todoViewDelegate = self
    }
    
    func addTodo() {
        TodoController.shared.addTodo(title: "Hola Mundo")
    }
    
    func onTodoAdded(todo: Todo) {
        
        print("El todo ha sido agregado: \(todo)")
    }
}

extension TodoView: TodoViewDelegate {
    
    func todo(todoAdded todo: Todo) {
        print("El todo ha sido agregado: \(todo)")
    }
}

let view = TodoView()

view.addTodo()
