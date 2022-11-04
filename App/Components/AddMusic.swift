//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 23/04/22.
//

//import SwiftUI
import AVKit

class AddMusic {
    private var audioPlayer: AVAudioPlayer
    var name: String
    private var format: String
    
    init(name: String, format: String) {
        self.name = name
        self.format = format
        self.audioPlayer = AVAudioPlayer()
        
    }
    
    func play(){
        let sound = Bundle.main.path(forResource: name, ofType: format)
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        self.audioPlayer.play()
    }
    
    func pauseSound(){
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
        
    }
    
    func continueSound(){
        audioPlayer.play()
        print("musica musica")
    }
    
    func stopSound(){
        audioPlayer.stop()
    }
    
    func setVolume(volume: Float){
        audioPlayer.setVolume(volume, fadeDuration: 3)
    }
    
    func playOnce(){
        let sound = Bundle.main.path(forResource: name, ofType: format)
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        self.audioPlayer.play()
    }
}

