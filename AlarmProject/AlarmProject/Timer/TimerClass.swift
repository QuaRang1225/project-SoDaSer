//
//  StopWatchClass.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI

enum modeTimer{
    case run
    case stop
    case pause
}
class TimerClass:ObservableObject{
    
    @Published var timeHoursElapsed = 0.0
    @Published var timeMinuteElapsed = 0.0
    @Published var timeSecondElapsed = 0.0
    
    @Published var stopMode:modeTimer = .stop
    
    var timer = Timer()
    func start(){
        stopMode = .run
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.timeHoursElapsed -= (1/3600)
            self.timeMinuteElapsed -= (1/60)
            self.timeSecondElapsed -= 1
            //print(self.timeElapsed)
        }
    }
    
    func stop(){
        timer.invalidate()
        timeHoursElapsed = 0
        timeMinuteElapsed = 0
        timeSecondElapsed = 0
        stopMode = .stop
    }
    func pause(){
        timer.invalidate()
        stopMode = .pause
    }
    
}
