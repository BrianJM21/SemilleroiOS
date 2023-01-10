//
//  ViewController.swift
//  6101_Combine
//
//  Created by User on 09/01/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var myLabel: UILabel!
    
    /// Creamos un publicador de tipo ´Bool/Never´
    @Published var encendido: Bool = true
    
    ///Creamos un suscriptor genérico de tipo `AnyCancellable`
    var encendidoSubscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        encendido = mySwitch.isOn
        
        //Conectamos el suscriptor al publicador
        encendidoSubscriber = $encendido.sink {
            valor in
            //Hacemos la lógica con el valor recibido desde el publicador y procesado por el suscriptor
            print("Se ha cambiado el switch a: \(valor)")
            
            if valor {
                
                self.myLabel.text = "ENCENDIDO"
            } else {
                
                self.myLabel.text = "APAGADO"
            }

        }
    }
    
    @IBAction func changeSwitchAction() {
        
        encendido = mySwitch.isOn
    }
}

