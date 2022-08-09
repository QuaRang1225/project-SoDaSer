//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct BackGroundTimer:View{

    
        
        @Environment(\.scenePhase) var scenePhase
        @State var timeRemaining: Double = 60
        @State private var totalTime: Double = 0
        @State private var startTime = Date.now
        
        var body: some View {
            Text(getTimeString(time:timeRemaining)).font(.system(size: 30)).foregroundColor(Color.black).fontWeight(.bold).padding()
                .onChange(of: scenePhase) { newValue in
                    switch newValue {
                    case .active:
                        bgTimer()
                    case .inactive:
                        print(".inactive")
                    case .background:
                        print("Background")
                    default:
                        print("scenePhase err")
                    }
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        } else {
                            Timer.invalidate()
                        }
                    })
                   
                }
            
        }
        
        func getTimeString(time: Double) -> String {
            let hour = Int(time) / 3600 % 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format: "%02i : %02i : %02i",hour, minutes, seconds)
        }
        
    func bgTimer() {
        let curTime = Date.now
        let diffTime = curTime.distance(to: startTime)
        let result = Double(diffTime.formatted())!
        timeRemaining = totalTime + result
        
        if timeRemaining < 0 {
            timeRemaining = 0
        }
    }
}
struct BackGroundTimer_Previews: PreviewProvider {
    static var previews: some View {
        BackGroundTimer()
    }
}
