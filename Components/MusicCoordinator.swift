//
//  File.swift
//  
//
//  Created by Maria Luiza Amaral on 23/04/22.
//

import AVKit

class MusicCoordinator {
    static let shared = MusicCoordinator()
    var musics : [AddMusic] = []
    
    private init(){}
    
    func addMusic(_ music: AddMusic) {
        musics.append(music)
    }
    
    func getMusic(byName name: String) -> AddMusic?{
        for music in musics where music.name == name {
            return music
        }
        return nil
        
        
    }
}
