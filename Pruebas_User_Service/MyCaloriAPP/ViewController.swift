//
//  ViewController.swift
//  MyCaloriAPP
//
//  Created by User on 19/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let userService = UserService()

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subscriber = self.userService.loadCoreDataUsersSubject.sink { completion in
            print(completion)
        } receiveValue: { users in
            print(users)
        }
        
        userService.loadCoreDataUsers()
    }
    
    @IBAction func RegistrateButtonAction(_ sender: Any) {
        
        userService.signUpEmailAndPassword(email: self.emailTextField.text!, password: self.passwordTextField.text!)
        
    }
    
    @IBAction  func loginButtonAction(_ sender: Any) {
        
        userService.loginWithEmailAndPassword(email: self.emailTextField.text!, password: self.passwordTextField.text!)
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        userService.logoutActiveUser()
    }
    
    @IBAction func verifyEmailAction(_ sender: Any) {
        
        userService.verifyEmailAlredySignedUp(self.emailTextField.text ?? "NO EMAIL")
    }
}
