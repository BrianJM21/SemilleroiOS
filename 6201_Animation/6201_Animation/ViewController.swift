//
//  ViewController.swift
//  6201_Animation
//
//  Created by User on 10/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseIn) {
            
            // Hacemos las animaciones
            
            // Desvanece la imagen
            //self.myImageView.alpha = 0
            
            // Hace una resize
            self.myImageView.bounds = CGRect(x: self.myImageView.bounds.midX, y: self.myImageView.bounds.midY, width: 20, height: 20)
            
            // Redondea la imagen
            //self.myImageView.layer.cornerRadius = self.myImageView.bounds.size.width / 2
        } completion: {
            
            ended in
            print ("Animación 1 terminada: \(ended)")
            
            UIView.animate(withDuration: 2, delay: 0.5, options: .curveLinear) {
                
                self.myImageView.alpha = 0
            } completion: {
                
                ended in
                print ("Animación 2 terminada: \(ended)")
                
                UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseOut) {
                    
                    self.view.backgroundColor = .black
                } completion: {
                    
                    ended in
                    print("Animación 3 terminada: \(ended)")
                }
            }
        }
    }


}

