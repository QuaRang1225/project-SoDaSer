//
//  StopWatchWindow.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI


struct StopWatchWindow:View{
    
    @Environment(\.managedObjectContext) var mac
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Entity.stopwatchList, ascending: true)]) var stopList: FetchedResults<Entity>
    
    @ObservedObject var stopWatchClass = StopWatchClass()
    @State private var animate = 0.0
    @State var textColor = Color.white
    @State private var animationAmount = false
    

    var body: some View{
        VStack{
            Spacer().frame(height:50)
            ZStack{
                Image("NIGHT")
                    .frame(width:150,height: 150)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 10, x: 0, y: 40)
                    .overlay(Circle().stroke(Color.white.opacity(0.3),lineWidth: 5).padding(5))
                    .overlay(Circle().stroke(Color.indigo,lineWidth: 5).padding(-5))
                    .opacity(animationAmount ? 0.5 : 1.0)
                Text(String(format: "%00.1f", stopWatchClass.timeElapsed)).font(.system(size: 50)).foregroundColor(textColor).fontWeight(.bold).padding()
                    
            }
            Spacer().frame(height:50)
            switch stopWatchClass.stopMode {
            case .stop:
                HStack{
                    Button(action: {
                        timeStore()
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.start()
                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)){
                            animationAmount.toggle()
                        }
                    }){
                        StopWatchButton(image: "play.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
            case .run:
                HStack{
                    Button(action: {
                        timeStore()
                        //print(time.stopwatchList)
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.pause()
                        animationAmount.toggle()
                    }){
                        StopWatchButton(image: "pause.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
                
            case .pause:
                HStack{
                    Button(action: {
                        timeStore()
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.start()
                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)){
                            animationAmount.toggle()
                        }
                    }){
                        StopWatchButton(image: "play.fill")
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
            }
            
            List{
                ForEach(stopList){ lap in
                    Text("\(lap.stopwatchList ?? "")초")
                }.onDelete(perform: deleteList)
  
            }.listStyle(PlainListStyle()).padding()

            
        }
        
    }
    func deleteList(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let times = stopList[index]
        mac.delete(times)
        try? mac.save()
    }
    func timeStore(){
        let time = Entity(context:mac)
        time.stopwatchList = String(format: "%00.1f", stopWatchClass.timeElapsed)
        try? mac.save()
    }
}
struct StopWatchWindow_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchWindow()
    }
}
