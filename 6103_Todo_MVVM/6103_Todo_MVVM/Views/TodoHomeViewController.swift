//
//  TodoHomeViewController.swift
//  6103_Todo_MVVM
//
//  Created by User on 09/01/23.
//

import UIKit
import Combine

class TodoHomeViewController: UIViewController {
    
    var todoHomeViewModel = TodoHomeViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    var todosSubscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.todosSubscriber = todoHomeViewModel.$todos.sink {
            
            todos in
            self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.todoHomeViewModel.loadTodos()
    }

}

extension TodoHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Todos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.todoHomeViewModel.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let todo = self.todoHomeViewModel.todos[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = todo.title
        config.secondaryText = todo.checked ? "DONE!!!" : "PENDING..."
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    
}

extension TodoHomeViewController: UITableViewDelegate {
    
    
}
