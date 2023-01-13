//
//  BitacoraDetailsViewController.swift
//  BitacorAPP
//
//  Created by Dragon on 12/01/23.
//

import UIKit

class BitacoraDetailsViewController: UIViewController {

    weak var viewModel: BitacoraDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "Bitacora Details"
    }

}
