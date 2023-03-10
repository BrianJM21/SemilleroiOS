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
        
        print("llama funci??n logout")
        
        do {
            
            try Auth.auth().signOut()
        } catch {
            
            print("no se pudo cerrar la sesi??n")
        }
    }
    
    @IBAction func signInMethodsButtonAction(_ sender: Any) {
        
        print("llama funcion signInMethods")
        
        Auth.auth().fetchSignInMethods(forEmail: self.emailTextField.text!) {
            
            methods, error in
            
            if let e = error {
                
                print(e)
            } else {
                
                if let m = methods {
                    
                    print(m)
                } else {
                    
                    print("El correo no se encontr?? en la base de datos")
                }
            }
        }
    }
    
    func fetchSignInMethods(forEmail email: String, completion: @escaping (Result<[String], Error>) -> Void) {
        
        Auth.auth().fetchSignInMethods(forEmail: email) {
            
          if let e = $1 {
              
              return completion(.failure(e))
          } else {
              
              let t = $0 == nil ? [] : $0!
              completion(.success(t))
          }
      }
    }
}

