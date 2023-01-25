//
//  UserService.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation
import Combine
import FirebaseAuth
import CoreData

class UserService {
    
    // Propiedades del UserService
    var activeUser: UserEntity?
    
    // Publicadores del UserService
    
    
    // Funcionalidades del UserService
    
    // En el proceso de registro, verifica si el correo se encuentra registrado
    func verifyEmailAlredySignedUp(_ email: String) {
        
        Auth.auth().signIn(withEmail: email, password: "_") {
            
            _, error in
            
            if let x = error {
                
                let err = x as NSError
                
                switch err.code {
                    
                    // Email ya existe en la FireBase
                case AuthErrorCode.wrongPassword.rawValue: print("wrong password")
                    
                    // Email no exitse en FireBase
                default: print("unknown error: \(err.localizedDescription)")

                }
            }
        }
    }
    
    
}
