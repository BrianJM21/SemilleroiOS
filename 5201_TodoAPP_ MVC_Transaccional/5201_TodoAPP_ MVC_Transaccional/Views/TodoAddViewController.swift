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
        
        TodoController.shared.addDelegate = self
        
    }
    
    @IBAction func addTodoAction(_ sender: Any) {
        if let title = titleTextField.text{
            TodoController.shared.addTodo(title: title)
        }
    }
    
}

extension TodoAddViewController: TodoAddDelegate {
    
    func todo(todoCreated todo: TodoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func todo(todoCreateError message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(<#T##action: UIAlertAction##UIAlertAction#>)
        
        alert.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
}
