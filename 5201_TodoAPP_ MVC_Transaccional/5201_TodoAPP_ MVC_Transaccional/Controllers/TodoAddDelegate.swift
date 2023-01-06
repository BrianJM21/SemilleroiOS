//
//  TodoAddDelegate.swift
//  5201_TodoAPP_ MVC_Transaccional
//
//  Created by User on 03/01/23.
//

import Foundation

protocol TodoAddDelegate {
    
    func todo(todoCreated todo: TodoEntity)
    
    func todo(todoCreateError message: String)
}
