//
//  HomeViewController.swift
//  Musicapp
//
//  Created by MacBook on 18/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Enlace al CollectionView del HomeView.
    
    
    @IBOutlet weak var searchBar: UIView!
    
    @IBOutlet weak var miniPlayer: UIView!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var playButton: UIButton!
    
    var miniPlayerAnimator: UIViewPropertyAnimator?
    var isPlaying: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registramos la celda y la vista reusable al CollectionView.
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
        self.homeCollectionView.register(UINib(nibName: "HomeCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionReusableView")
        
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        
        self.searchBar.backgroundColor = UIColor.blue
        self.miniPlayer.backgroundColor = UIColor.green
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        if self.isPlaying {
            
            self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.isPlaying = !self.isPlaying
        } else {
            
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.isPlaying = !self.isPlaying
        }
        
        print("\(self.isPlaying)")
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath)
        
        if let cell = cell as? HomeCollectionViewCell {
            
            cell.setupSongImage(UIImage(systemName: "music.note.house.fill")!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeCollectionReusableView", for: indexPath)
        
        if let reusableView = reusableView as? HomeCollectionReusableView {
            
            reusableView.setupGeneroCancionesLabel(genero: "\(indexPath.section)", canciones: "\(indexPath.row)")
        }
        
        return reusableView
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            if self.isPlaying {
                
                UIView.animate(withDuration: 2, delay: 0, options: .curveLinear) {
                    
                    self.miniPlayer.backgroundColor = UIColor.white
                }
                
                self.isPlaying = !self.isPlaying
                
            } else {
             
                UIView.animate(withDuration: 2, delay: 0, options: .curveLinear) {
                    
                    self.miniPlayer.backgroundColor = UIColor.green
                }
                
                self.isPlaying = !self.isPlaying
            }
            
            print("\(isPlaying)")
        }
    }
}
