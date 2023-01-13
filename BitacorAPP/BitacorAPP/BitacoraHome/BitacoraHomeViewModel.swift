//
//  BitacoraHomeViewModel.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import Foundation
import Combine

class BitacoraHomeViewModel {
    
    weak var model: BitacoraModel?
    weak var view: BitacoraHomeView?

    // TODO: Documentanción definicion
    
    var bitacorasSubscriber: AnyCancellable?
    var bitacoraSelectedSubscriber: AnyCancellable?
    
    init(model: BitacoraModel) {
        
        // TODO: Documentación Suscribtores a Bitacoras
        self.model = model
        
        self.bitacorasSubscriber = model.$bitacoras.sink(receiveValue: { [weak self] bitacoras in
            self?.view?.bitacora(bitacoras: bitacoras)
        })
        
        // TODO: Suscribtores a Bitacora Seleccionada
        self.bitacoraSelectedSubscriber = model.$bitacoraSelected.sink(receiveValue: { [weak self] bitacora in
            if let bitacora = bitacora {
                self?.view?.bitacora(bitacoraSelected: bitacora)
            }
        })
        
        // TODO: Documentación Función Cargar Bitacota
        func addBitacora(latitude lat: Decimal, longitude lon: Decimal) {
            self.model?.addBitacora(latitude: lat, longitude: lon)
        }
        
        // TODO: Documentación Funcion Selecccionar ID
        func selectBitacora(byId id: Int) {
            self.model?.selectBitacora(byId: id)
        }
    }
}
