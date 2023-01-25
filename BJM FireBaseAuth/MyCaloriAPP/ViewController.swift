//
//  ViewController.swift
//  MyCaloriAPP
//
//  Created by User on 19/01/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var auth = AuthenticationFireBaseDataSource()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func RegistrateButtonAction(_ sender: Any) {
        
        print("llama funcion registrar usuario")
        
        if let email = self.emailTextField.text {
            
            if let password = passwordTextField.text {
                
                self.auth.createNewUser(email: email, password: password) { result in
                    
                    print(result)
                }
            }
        }
    }
    
  @IBAction  func loginButtonAction(_ sender: Any) {
        
        print("llama funcion login usuario")
        
        if let email = self.emailTextField.text {
            
            if let password = passwordTextField.text {
                
                Auth.auth().signIn(withEmail: email, password: password) {
                    
                    user, error in
                    
                   if let x = error {
                       
                      let err = x as NSError
                       
                      switch err.code {
                          
                      case AuthErrorCode.wrongPassword.rawValue: print("wrong password")
                      case AuthErrorCode.invalidEmail.rawValue: print("invalid email")
                      case AuthErrorCode.accountExistsWithDifferentCredential.rawValue: print("accountExistsWithDifferentCredential")
                          
                          // el que nos interesa
                      case AuthErrorCode.emailAlreadyInUse.rawValue: print("email is alreay in use")
                          
                      case AuthErrorCode.
                      default: print("unknown error: \(err.localizedDescription)")
                      }
                      //return
                   } else {
                      //continue to app
                       print(user?.user ?? "SIN RESULTADO/USUARIO")
                   }
                }
            }
        }
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        print("llama función logout")
        
        do {
            
            try Auth.auth().signOut()
        } catch {
            
            print("no se pudo cerrar la sesión")
        }
    }
    
    

}

