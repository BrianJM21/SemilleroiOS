//
//  ViewController.swift
//  Animaciones
//
//  Created by User on 10/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var radiusAnimator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.radiusAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeIn) {
            self.myImageView.layer.cornerRadius = self.myImageView.bounds.size.width / 2
        }
    }
    
    @IBAction func startAnimationAction(_ sender: Any) {
        
        self.radiusAnimator?.startAnimation()
    }
    
}
