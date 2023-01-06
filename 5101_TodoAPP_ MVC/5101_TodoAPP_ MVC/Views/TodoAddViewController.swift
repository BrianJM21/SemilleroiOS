//
//  TodoAddViewController.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import UIKit

class TodoAddViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addTodoAction(_ sender: Any) {
        if let title = titleTextField.text{
            TodoController.shared.addTodo(title: title, onTodoCreated: self)
        }
    }
    
}

extension TodoAddViewController: TodoCreatable {
    
}
