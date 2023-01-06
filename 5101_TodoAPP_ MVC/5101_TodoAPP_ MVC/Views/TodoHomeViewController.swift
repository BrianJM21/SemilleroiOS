//
//  TodoHomeViewController.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import UIKit

class TodoHomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var todos: [TodoEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        TodoController.shared.getTodo(onTodos: self)
    }

}

extension TodoHomeViewController: TodoGetable {
    
    func onTodos(todos: [TodoEntity]) {
        self.todos = todos
        tableView.reloadData()
    }
}

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter.string(from: self)
    }
}

extension TodoHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Todos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        
        let todo = self.todos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        if let title = todo.title {
            config.text = "\(todo.checked ? "ON" : "OFF") \(title)"
        }
        
        var secondaryText = ""
        
        if let createdAt = todo.createdAt {
            secondaryText += createdAt.toString()
        }
        
        if let updatedAt = todo.updatedAt {
            secondaryText += updatedAt.toString()
        }
        
        config.secondaryText = secondaryText
        
        cell.contentConfiguration = config
        
        return cell
        
    }
}

extension TodoHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = self.todos[indexPath.row]
        
        self.performSegue(withIdentifier: "TodoDetailSegue", sender: (todo: todo, index: indexPath.row))
    }
}

extension TodoHomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let todoDetailsViewController = segue.destination as? TodoDetailsViewController {
            
            if let todoData = sender as? (
        }
    }
}
