//
//  HomeCollectionReusableView.swift
//  Ejercicio_Collections
//
//  Created by User on 17/01/23.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(title: String, subtitle: String){
        
        self.titleLabel.text = title
        
        self.subtitleLabel.text = subtitle
        
    }
    
}
