//
//  TimerWindow.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/08/02.
//

import Foundation
import SwiftUI

extension UIPickerView {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
struct TimerWindow:View{
    
    @EnvironmentObject var timerClass : TimerClass
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    @State var hourSelction = 0
    @State var minuteSelction = 0
    @State var secondSelction = 0
    @Environment(\.scenePhase) var scenePhase
    @State var timeRemaining: Double = 0
    @State private var totalTime: Double = 0
    @State private var startTime = Date()
    @State private var stopTime = Date()
    @State var onOff = false
    
    var body: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
                Image("NIGHT")
                    .clipShape(Rectangle())
                    .foregroundColor(.indigo).frame(width: 75, height: 20).cornerRadius(5)
                    .overlay(Rectangle().stroke(Color.gray.opacity(0.8),lineWidth: 20).padding(-5).cornerRadius(5))
               
                    ZStack{
                        
                            
                        Image("NIGHT").resizable()
                            .clipShape(Rectangle()).foregroundColor(.indigo).cornerRadius(20)
                            .overlay(Rectangle().stroke(Color.gray.opacity(0.8),lineWidth: 20).padding(-5).cornerRadius(10))
                        
                        HStack{
                            Text(getTimeString(time: ceil(timerClass.timeElapsed))).font(.system(size: 50)).foregroundColor(.white).fontWeight(.bold).padding().onChange(of: scenePhase) { newValue in
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

                
                        }
                            
                            
                    }
                        
                    
                    
                
                
                //Spacer().frame(height: 40)
                GeometryReader { geometry in
                    HStack(spacing:0){
                        
                        Picker(selection: self.$hourSelction, label: Text("")){
                            ForEach(0..<self.hours.count){ index in
                                Text("\(self.hours[index])시간").foregroundColor(.gray)
                                
                                
                            }
                            
                        }.pickerStyle(.wheel)
                            .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center).clipped()
                            .compositingGroup()
                            
                        Picker(selection: self.$minuteSelction, label: Text("")){
                            ForEach(0..<self.minutes.count){ index in
                                Text("\(self.minutes[index])분").foregroundColor(.gray)
                            }
                        }.pickerStyle(.wheel)
                            .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center).clipped()
                            .compositingGroup()
                            
                       // Spacer()
                        Picker(selection: self.$secondSelction, label: Text("")){
                            ForEach(0..<self.seconds.count){ index in
                                Text("\(self.seconds[index])초").foregroundColor(.gray)
                            }
                        }.pickerStyle(.wheel)
                            .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center).clipped()
                            .compositingGroup()
                            //.clipped()
                        Spacer()
                        
                    }
                        
                }
                //Spacer().frame(height: 50)
                switch timerClass.stopMode{
                case .stop:
                    HStack{
                        Button(action: {
                            timerClass.start()
                            timerClass.timeElapsed = Double(hourSelction * 3600 + minuteSelction * 60 + secondSelction)
                            totalTime = timerClass.timeElapsed
                            if totalTime > 0{
                                startTime = Date.now
                                stopTime = startTime
                                onOff = true
                                AlertTimer().alretTimer(timeinterval: Int(totalTime), timeName: getTimeString(time: totalTime))
                                print(totalTime)
                            }
                            
                        }){
                            StopWatchButton(image: "play.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
                            onOff = false
                            AlertTimer().caancelAlarm()
                        }){
                            StopWatchButton(image: "stop.fill")
                        }
                    }
                    
                case .run:
                    HStack{
                        Button(action: {
                            timerClass.pause()
                            onOff = false
                            AlertTimer().caancelAlarm()
                        }){
                            StopWatchButton(image: "pause.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
                            onOff = false
                            AlertTimer().caancelAlarm()
                        }){
                            StopWatchButton(image: "stop.fill")
                        }
                    }
                case .pause:
                    HStack{
                        Button(action: {
                            timerClass.start()
                            startTime = stopTime
                            onOff = true
                            AlertTimer().alretTimer(timeinterval: Int(totalTime), timeName: getTimeString(time: totalTime))
                        }){
                            StopWatchButton(image: "play.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
                            onOff = false
                            AlertTimer().caancelAlarm()
                        }){
                            StopWatchButton(image: "stop.fill")
                        }
                    }
                }
                Spacer()
            }
            Spacer()
        }.background(Color.white)
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
        print(curTime)
        print(diffTime)
        print(result)
        if onOff{
            timerClass.timeElapsed = totalTime + result
        }
        if timerClass.timeElapsed <= 0{
            timerClass.timeElapsed = 0
        }

    }
    
}

struct TimerWindow_Previews: PreviewProvider {
    static var previews: some View {
        TimerWindow().environmentObject(TimerClass())
    }
}
