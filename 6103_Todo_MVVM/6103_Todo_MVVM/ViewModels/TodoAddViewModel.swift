//
//  TodoAddViewModel.swift
//  6103_Todo_MVVM
//
//  Created by User on 09/01/23.
//

import Foundation
import Combine

class TodoAddViewModel {
    
    var sessionId: Int = Int.random(in: 1...Int.max)
    var title: String = ""
    
    @Published var todoAdded: TodoEntity?
    
    var todoAddedSubscriber: AnyCancellable?
    
    init() {
        
        self.todoAddedSubscriber = TodoModel.shared.$todoAdded.dropFirst().sink {
            
            (sessionId, todo) in
            if self.sessionId == sessionId {
                self.todoAdded = todo
            }
        }
    }
    
    deinit {
        
        self.todoAddedSubscriber?.cancel()
        self.todoAddedSubscriber = nil
    }
    
    func setTitle(title: String) {
        
        self.title = title
        print("ajustando titulo: \(self.title)")
    }
    
    func addTodo() {
        self.sessionId = Int.random(in: 1...Int.max)
        TodoModel.shared.addTodo(sessionId: sessionId, title: title)
    }
}
