//
//  SoundsBootcamp9.swift
//  SwiftUIContinuedLearning
//
//  Created by Joel Bearn on 05/10/2022.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case duck = "Duck-quack"
        case badum = "Badum-tss"
    }
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print("error playing sound \(error.localizedDescription)")
        }
        
        
    }
    
}

struct SoundsBootcamp9: View {
    
    var soundManager = SoundManager.instance
    
    var body: some View {
        VStack(spacing: 40){
            Button("Play sound 1") {
                soundManager.playSound(sound: .duck)
            }
            Button("Play sound 2") {
                soundManager.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp9_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp9()
    }
}
