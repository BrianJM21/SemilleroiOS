//
//  TodoEditViewController.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import UIKit

class TodoEditViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var checkedSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func saveAction(_ sender: Any) {
        
        if let title = titleTextField.text{
            TodoController.shared.updateTodoTitle(title: title)
        }
        
        TodoController.shared.updateTodoCheck(checked: checkedSwitch.isOn)
        
    }

}
