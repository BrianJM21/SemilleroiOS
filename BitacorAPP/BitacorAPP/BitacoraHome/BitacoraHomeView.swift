//
//  BitacoraHomeView.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import Foundation

// TODO: Documentanción definicion de los protocolos

protocol BitacoraHomeView: NSObject {
    
    func bitacora(bitacoras: [BitacoraEntity])
    
    func bitacora(bitacoraSelected: BitacoraEntity)
}
