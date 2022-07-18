//
//  ContentView.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import SwiftUI

struct ContentView: View {
    
    @State private var worldTime:Bool = false
    @State private var alarm:Bool = false
    @State private var stopWatch:Bool = false
    @State private var timer:Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("알람어플").font(.system(size: 40)).fontWeight(.black)
                Spacer()
                NavigationLink(destination: WoldTime(worldTime:self.$worldTime)){
                    Banner(icon: "network", color: Color.green, content: "세계시계").padding(.trailing,100)
                }
                Spacer()
                NavigationLink(destination: Alarm(alarm:self.$alarm)){
                    Banner(icon: "alarm.fill", color: Color.blue, content: "알람").padding(.leading,100)
                }
                Spacer()
                NavigationLink(destination: StopWatch(stopwatch:self.$stopWatch)){
                    Banner(icon: "stopwatch.fill", color: Color.red, content: "스톱워치").padding(.trailing,100)
                }
                Spacer()
                NavigationLink(destination: Timer(timer:self.$timer)){
                    Banner(icon: "timer", color: Color.yellow, content: "타이머").padding(.leading,100)
                }
                Spacer()
                
            }.padding()
                .navigationTitle("메인화면")
                .navigationBarHidden(self.worldTime)
                .navigationBarHidden(self.alarm)
                .navigationBarHidden(self.stopWatch)
                .navigationBarHidden(self.timer)
                .onAppear(){
                    self.worldTime = true
                    self.alarm = true
                    self.stopWatch = true
                    self.timer = true
                }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
