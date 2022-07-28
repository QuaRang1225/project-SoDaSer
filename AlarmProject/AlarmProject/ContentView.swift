//
//  ContentView.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import SwiftUI


struct ContentView: View {
    
    @State var currentDate = Date()
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @StateObject private var store = TimeListStore()
    @State private var worldTime:Bool = false
    @State private var alarm:Bool = false
    @State private var stopWatch:Bool = false
    @State private var timer:Bool = false
    
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm':'ss a"
        return formatter
        
    }
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
    
                VStack{
                    Text("알람어플").font(.system(size: 40)).fontWeight(.black).foregroundColor(.white).padding()
                              
                    Spacer()
                    NavigationLink(destination: WoldTime(worldTime:self.$worldTime)){
                        Banner(icon: "network", color: Color.white, content: "세계시계").padding(.trailing,100)
                    }
                    Spacer()
                    NavigationLink(destination: Alarm(alarm:self.$alarm).environment(\.managedObjectContext, store.container.viewContext)){
                        Banner(icon: "alarm.fill", color: Color.white, content: "알람").padding(.leading,100)
                    }
                    Spacer()
                    NavigationLink(destination: StopWatch(stopWatch:self.$stopWatch)){
                        Banner(icon: "stopwatch.fill", color: Color.white, content: "스톱워치").padding(.trailing,100)
                    }
                    Spacer()
                    NavigationLink(destination: TimerCount(timer:self.$timer)){
                        Banner(icon: "timer", color: Color.white, content: "타이머").padding(.leading,100)
                    }
                  
                    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
