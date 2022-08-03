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
    
    @ObservedObject var timerClass = TimerClass()
    
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    @State var hourSelction = 0
    @State var minuteSelction = 0
    @State var secondSelction = 0
    
    var body: some View{
        HStack{
            Spacer()
            VStack{
                Spacer()
                
                           
                //Spacer().frame(height: 20)
                Image("NIGHT")
                    .clipShape(Rectangle())
                    .foregroundColor(.indigo).frame(width: 75, height: 20).cornerRadius(5)
                    .overlay(Rectangle().stroke(Color.gray.opacity(0.8),lineWidth: 20).padding(-5).cornerRadius(5))
               
                    ZStack{
                        
                            
                        Image("NIGHT").resizable()
                            .clipShape(Rectangle()).foregroundColor(.indigo).cornerRadius(20)
                            .overlay(Rectangle().stroke(Color.gray.opacity(0.8),lineWidth: 20).padding(-5).cornerRadius(10))
                        HStack{
                            Text(String(format: "%0.0f시간", timerClass.timeHoursElapsed)).font(.system(size: 30)).foregroundColor(Color.white).fontWeight(.bold).padding()
                            Text(String(format: "%0.0f분", timerClass.timeMinuteElapsed)).font(.system(size: 30)).foregroundColor(Color.white).fontWeight(.bold).padding()
                            Text(String(format: "%0.0f초", timerClass.timeSecondElapsed)).font(.system(size: 30)).foregroundColor(Color.white).fontWeight(.bold).padding()
                        }
                        
                    }
                    
                
                
                //Spacer().frame(height: 20)
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
                            timerClass.timeHoursElapsed = Double(hourSelction)
                            timerClass.timeMinuteElapsed = Double(minuteSelction)
                            timerClass.timeSecondElapsed = Double(secondSelction)
                            //print(hourSelction)
                            
                        }){
                            StopWatchButton(image: "play.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
                        }){
                            StopWatchButton(image: "stop.fill")
                        }
                    }
                    
                case .run:
                    HStack{
                        Button(action: {
                            timerClass.pause()
                        }){
                            StopWatchButton(image: "pause.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
                        }){
                            StopWatchButton(image: "stop.fill")
                        }
                    }
                case .pause:
                    HStack{
                        Button(action: {
                            timerClass.start()
                        }){
                            StopWatchButton(image: "play.fill")
                        }
                        Spacer().frame(width: 30)
                        Button(action: {
                            timerClass.stop()
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
}

struct TimerWindow_Previews: PreviewProvider {
    static var previews: some View {
        TimerWindow()
    }
}
