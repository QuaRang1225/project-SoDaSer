//
//  StopWatchClass.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI
import CoreData

enum modeTimer{
    case run
    case stop
    case pause
}
class TimerClass:ObservableObject{
    
    
    @Published var timeElapsed:Double = 0.0
    
    @Published var stopMode:modeTimer = .stop

    
    var timer = Timer()
    func start(){
        stopMode = .run
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            
            self.timeElapsed -= 0.1
            if self.timeElapsed <= 0{
                timer.invalidate()
                self.stopMode = .stop
                print(self.timeElapsed)
                
            }
            
        }
        
        
    }
    
    func stop(){
        timer.invalidate()
        timeElapsed = 0.0
        stopMode = .stop
    }
    func pause(){
        timer.invalidate()
        stopMode = .pause
    }
    
}
