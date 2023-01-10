//
//  TodoAddViewController.swift
//  6103_Todo_MVVM
//
//  Created by User on 09/01/23.
//

import UIKit
import Combine

class TodoAddViewController: UIViewController {
    
    var addViewModel = TodoAddViewModel()
    
    var todoAddedSubscriber: AnyCancellable?
    
    @IBOutlet weak var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todoAddedSubscriber = self.addViewModel.$todoAdded.sink {
            todo in
            if let _ = todo {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "No se pudo crear el todo", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }

    }
    
    @IBAction func changeTitleAction() {
        if let title = titleTextField.text {
            
            addViewModel.setTitle(title: title)
        }
    }
    
    @IBAction func addTodoAction() {
        
        addViewModel.addTodo()
    }

}
