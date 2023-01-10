import UIKit

struct Todo {
    
    let title: String
    let checked: Bool
}

class TodoModel {
    
    var todos: [Todo] = []
    
}

class TodoController {
    
    static let shared = TodoController()
    
    var model = TodoModel()
    
    var whenTodoAdded: ((Todo) -> Void)?
    
    func addTodo(title: String) {
        
        print("Creando nuevo Todo")
        
        let todo = Todo(title: title, checked: false)
        
        print("Agregando nuevo Todo al modelo")
        
        model.todos.append(todo)
        
        print("Notificando a la vista que el Todo ha sido creado")
        
        if let whenTodoAdded = self.whenTodoAdded {
            
            print("Se ha notificado a la vista conectada al controlador")
            whenTodoAdded(todo)
        } else {
            
            print("No hay ninguna vista que se haya conectado para el resultado de haber creado el Todo")
        }
    }
}

class TodoView {
    
    init() {
        
        TodoController.shared.whenTodoAdded = self.onTodoAdded
    }
    
    func addTodo() {
        TodoController.shared.addTodo(title: "Hola Mundo")
    }
    
    func onTodoAdded(todo: Todo) {
        
        print("El todo ha sido agregado: \(todo)")
    }
}

let view = TodoView()

view.addTodo()
