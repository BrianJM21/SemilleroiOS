//
//  TodoEditDelegate.swift
//  5201_TodoAPP_ MVC_Transaccional
//
//  Created by User on 03/01/23.
//

import Foundation

protocol TodoEditDelegate {
    
    func todo(todoEdited todo: TodoEntity)
    
    func todo(todoEditError message: String)
    
    func todo(todoDeleted todo: TodoEntity)
}
