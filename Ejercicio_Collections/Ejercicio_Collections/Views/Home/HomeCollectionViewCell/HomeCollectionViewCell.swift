//
//  HomeCollectionViewCell.swift
//  Ejercicio_Collections
//
//  Created by User on 17/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var musicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(label: String) {
        
        musicLabel.text = label
    }
}
