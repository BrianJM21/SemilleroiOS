//
//  HomeViewController.swift
//  Ejercicio_Collections
//
//  Created by User on 17/01/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var musicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.musicCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MusicCollectionViewCell")
        
        self.musicCollectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MusicCollectionReusableView")
        
        self.musicCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCollectionViewCell", for: indexPath)
        
        if let cell = cell as? HomeCollectionViewCell {
            
            cell.setup(label: "Música \(indexPath.section) \(indexPath.row)")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MusicCollectionReusableView", for: indexPath)
        
        if let reusableView = reusableView as? HomeCollectionReusableView {
            
            reusableView.setup(title: "\(indexPath.section)", subtitle: "\(indexPath.row)")
        }
        
        return reusableView
    }
    
}
