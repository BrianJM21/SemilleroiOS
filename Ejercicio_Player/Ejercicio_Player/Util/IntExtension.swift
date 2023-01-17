//
//  IntExtension.swift
//  Ejercicio_Player
//
//  Created by User on 17/01/23.
//

import Foundation

extension Int {
    
    func fixed(digits n: Int) -> String {
        
        var text = "\(self)"
        
        while text.count < n {
            
            text = "0" + text
        }
        
        return String(text.suffix(n))
    }
}
