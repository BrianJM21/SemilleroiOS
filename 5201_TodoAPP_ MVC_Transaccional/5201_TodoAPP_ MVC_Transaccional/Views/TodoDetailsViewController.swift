//
//  TodoDetailsViewController.swift
//  5101_TodoAPP_ MVC
//
//  Created by User on 02/01/23.
//

import UIKit

class TodoDetailsViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var checkedLabel: UILabel!

    @IBOutlet var createdAtLabel: UILabel!
    
    @IBOutlet var updatedAtLabel: UILabel!


    
    var todo: TodoEntity?
    var todoIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            
            titleLabel.text = todo.title ?? "Sin título"
            checkedLabel.text = todo.checked ? "ON" : "OFF"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
