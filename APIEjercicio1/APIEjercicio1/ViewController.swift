//
//  ViewController.swift
//  APIEjercicio1
//
//  Created by User on 03/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = ViewModel()
    
    @IBAction func urlActionButton(_ sender: Any) {
        
        viewModel.executeAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }


}

