//
//  DateExtensions.swift
//  5201_TodoAPP_ MVC_Transaccional
//
//  Created by User on 03/01/23.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter.string(from: self)
    }
}
