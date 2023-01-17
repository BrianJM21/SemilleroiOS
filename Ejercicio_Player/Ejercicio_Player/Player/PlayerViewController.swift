//
//  PlayerViewController.swift
//  Ejercicio_Player
//
//  Created by User on 17/01/23.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var isPlaying = false
    var isShuffle = false
    var isRepeating = false
    var isLocked = false
    var isAudioLoading = false
    
    var duration: Int = 0
    var currentTime: Int = 0
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    
    @IBOutlet weak var timeProgressView: UIProgressView!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var shuffleButton: UIButton!
    
    @IBOutlet weak var backwardButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var repeatButton: UIButton!
    
    var shuffleLineView: UIView!
    
    var repeatDotView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPlayer()
        
        self.loadPlayerItem()
        
        self.setPlayerItem()
        
        self.refreshPlayer()
    }
    
    func createPlayer() {
        
        self.player = AVPlayer()
        
        if let player = self.player {
            
            player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) {
                
                [weak self] _ in
                
                self?.refreshPlayer()
            }
        }
    }
    
    func loadPlayerItem() {
        
        if let url = URL(string: "https://vgmsite.com/soundtracks/donkey-kong-64-official-soundtrack/hyxfnkpdvi/03.%20Jungle%20Melody.mp3") {
//        if let url = URL(string: "https://samplelib.com/lib/preview/mp3/sample-15s.mp3") {
            
            self.playerItem = AVPlayerItem(url: url)
        }
    }
    
    func setPlayerItem() {
        
        if let player = self.player {
            
            if let playerItem = self.playerItem {
                
                player.replaceCurrentItem(with: playerItem)
                
                self.isAudioLoading = true
                
                self.refreshPlayer()
            }
        }
    }
    
    func refreshPlayer() {
        
        if let player = self.player {
            
//            if let currentItem = player.currentTime {
                self.currentTime = Int(player.currentTime().seconds)
//
//                if currentItem.loadedTimeRanges.count >= 1 {
//
//                    let duration = currentItem.loaded
//            }
            
            if let currentItem = player.currentItem {
                
                if currentItem.duration.seconds.isInfinite || currentItem.duration.seconds.isNaN {
                    
                    self.duration = 0
                } else {
                    
                    self.duration = Int(currentItem.duration.seconds)
                }
            }
        }
        
        if self.isAudioLoading {
            
            self.playButton.isEnabled = true
            
            if isPlaying {
                
                playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                
                if currentTime > 5 {
                    
                    playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                } else {
                    
                    playButton.setImage(UIImage(systemName: "play"), for: .normal)
                }
            }
        } else {
            
            self.playButton.setImage(UIImage(systemName: "play.slash"), for: .normal)
            
            self.playButton.isEnabled = false
        }
        
        if self.currentTime == 0 && self.duration == 0 {
            
            self.timeProgressView.progress = 0
        } else {
            
            self.timeProgressView.progress = Float(self.currentTime) / Float(self.duration)
        }
        
        let currentTimeInMinutes = Int(Double(self.currentTime)/60.0)
        
        let currentTimeInSeconds = self.currentTime % 60
        
        self.currentTimeLabel.text = "\(currentTimeInMinutes):\(currentTimeInSeconds.fixed(digits: 2))"
        
        let durationInMinutes = Int(Double(self.duration)/60.0)
        
        let durationInSeconds = self.duration % 60
        
        self.durationLabel.text = "\(durationInMinutes):\(durationInSeconds.fixed(digits: 2))"
        
        if isShuffle {
            
            if let shuffleLineView = self.shuffleLineView {
                
                self.shuffleButton.addSubview(shuffleLineView)
            } else {
                
                let shuffleLineView = UIView(frame: CGRect(x: self.shuffleButton.frame.size.width / 4, y: self.shuffleButton.frame.size.height, width: self.shuffleButton.frame.size.width / 2, height: 2))
                
                shuffleLineView.backgroundColor = UIColor.systemBlue
                
                self.shuffleLineView = shuffleLineView
                self.shuffleButton.addSubview(shuffleLineView)
            }
        } else {
            
            if let shuffleLineView = self.shuffleLineView {
                
                self.shuffleButton.willRemoveSubview(shuffleLineView)
                shuffleLineView.removeFromSuperview()
            }
        }
        
        if isRepeating {
            
            if let repeatDotView = self.repeatDotView {
                
                repeatButton.addSubview(repeatDotView)
                
            } else {
                
                let repeatDotView = UIView(frame: CGRect(x: self.repeatButton.frame.size.width / 2 - 2, y: self.repeatButton.frame.size.height - 2, width: 4, height: 4))
                
                repeatDotView.layer.cornerRadius = 2
                repeatDotView.backgroundColor = UIColor.systemBlue
                
                self.repeatDotView = repeatDotView
                self.repeatButton.addSubview(repeatDotView)
            }
        } else {
            
            if let repeatDotView = self.repeatDotView {
                
                self.repeatButton.willRemoveSubview(repeatDotView)
                repeatDotView.removeFromSuperview()
            }
        }
    
    }
    
    @IBAction func shuffleAction(_ sender: Any) {
        
        self.isShuffle = !self.isShuffle
        self.refreshPlayer()
    }
    
    @IBAction func backwardAction(_ sender: Any) {
        
        self.refreshPlayer()
    }
    
    @IBAction func playAction(_ sender: Any) {
        
        if let player = self.player {
            
            if self.isPlaying {
                
                player.pause()
            } else {
                
                player.play()
            }
        }
        
        self.isPlaying = !self.isPlaying
        
        self.refreshPlayer()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        
        self.refreshPlayer()
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        
        self.isRepeating = !self.isRepeating
        self.refreshPlayer()
    }
    
}
