//
//  StopWatchWindow.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI

struct LapClass:Identifiable{
    var id = UUID()
    let lap:Double
    init(_ lap:Double){
        self.lap = lap
    }
}
struct StopWatchWindow:View{
    
    @ObservedObject var stopWatchClass = StopWatchClass()
    @State var lapTimeing:[LapClass] = []
    
    var body: some View{
        VStack{
            Spacer().frame(height:50)
            ZStack{
                
                Image("NIGHT")
                    .frame(width:200,height: 200)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 10, x: 0, y: 40)
                    .overlay(Circle().stroke(Color.white.opacity(0.3),lineWidth: 5).padding(5))
                    .overlay(Circle().stroke(Color.indigo,lineWidth: 5).padding(-5))
                   
                
                Text(String(format: "%00.1f", stopWatchClass.timeElapsed)).font(.system(size: 50)).foregroundColor(.white).fontWeight(.bold).padding()
            }
            Spacer().frame(height:50)
            
            switch stopWatchClass.stopMode {
            case .stop:
                HStack{
                    withAnimation{
                        Button(action: {
                            let newLap = LapClass(stopWatchClass.timeElapsed)
                            lapTimeing.append(newLap)
                        }){
                            Image(systemName: "stopwatch.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.start()
                        }){
                            Image(systemName: "play.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.stop()
                        }){
                            Image(systemName: "stop.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                }
                
            case .run:
                HStack{
                    withAnimation{
                        Button(action: {
                            let newLap = LapClass(stopWatchClass.timeElapsed)
                            lapTimeing.append(newLap)
                        }){
                            Image(systemName: "stopwatch.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.pause()
                        }){
                            Image(systemName: "pause.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.stop()
                        }){
                            Image(systemName: "stop.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    
                    
                }
                
            case .pause:
                HStack{
                    withAnimation{
                        Button(action: {
                            let newLap = LapClass(stopWatchClass.timeElapsed)
                            lapTimeing.append(newLap)
                        }){
                            Image(systemName: "stopwatch.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.start()
                        }){
                            Image(systemName: "play.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                    Spacer().frame(width: 20)
                    withAnimation{
                        Button(action: {
                            stopWatchClass.stop()
                        }){
                            Image(systemName: "stop.fill").font(.system(size: 50)).foregroundColor(.indigo)
                        }
                    }
                }
                
            }
            
            
            List(lapTimeing){ lap in
                Text("\(String(format: "%00.1f", lap.lap))초")
            }.listStyle(PlainListStyle()).padding()

            
          
            
                
            //Spacer()//.frame(height:180)
        }
    }
}
struct StopWatchWindow_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchWindow()
    }
}
