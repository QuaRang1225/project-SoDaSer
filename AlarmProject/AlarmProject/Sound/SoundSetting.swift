//
//  SoundSetting.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI
import AVFoundation

class SoundSetting: ObservableObject {
    
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case Tada
        case Thunder
        case Opening
        
    }
   
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
            
        }
    }
}
