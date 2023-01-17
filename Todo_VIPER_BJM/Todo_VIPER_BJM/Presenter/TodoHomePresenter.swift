//
//  TodoHomePresenter.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation

class TodoHomePresenter {
    
    weak var router: TodoRouter?
    
    weak var interactor: TodoInteractor?
    
    weak var view: TodoHomeView?
    
    lazy var viewController: TodoHomeViewController = {
        
        let viewController = TodoHomeViewController()
        
        viewController.presenter = self
        self.view? = viewController
        
        return viewController
    }()
    
    
}
