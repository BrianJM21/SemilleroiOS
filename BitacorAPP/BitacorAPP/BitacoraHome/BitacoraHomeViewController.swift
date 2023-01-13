//
//  BitacoraHomeViewController.swift
//  BitacorAPP
//
//  Created by MacBook Pro on 12/01/23.
//

import UIKit
import MapKit

class BitacoraHomeViewController: UIViewController {
    // TODO: Documentanción definicion IBOULETS
    
    
    weak var viewModel: BitacoraHomeViewModel?
    
    @IBOutlet weak var homeMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goDetailsAction(_ sender: Any) {
        
        self.navigationController?.pushViewController(BitacoraDetailsViewController(), animated: true)
    }
}

extension BitacoraHomeViewController: BitacoraHomeView {
    func bitacora(bitacoras: [BitacoraEntity]) {
        // TODO: Implementación en el mapa con las bitacoras
    }
    
    func bitacora(bitacoraSelected: BitacoraEntity) {
        // TODO: Implementación en el mapa cuando la bitacora sea seleccionada
    }
    
    
}
