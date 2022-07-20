
//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
import UserNotifications
import UserNotificationsUI
import NotificationCenter
import BackgroundTasks



class SoundSetting: ObservableObject {        //1. soundSetting의 단일 인스턴스를 만듬    /// singleton ? :    /*싱글 톤은 한 번만 생성 된 다음 사용해야하는 모든 곳에서 공유해야하는 객체입니다 */
    
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

struct Alarm:View{
    
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //@EnvironmentObject var contentVeiw:ContentView
    
    @State var alarmAdd: Bool = false
    @State var button:String = "plus.app.fill"
    @State private var wakeup = Date()
    @State private var current = Date()
    @State private var pushTime=String()
    @State private var currentTime=String()
    @State private var pushTime1=String()
    @State private var item:Int = 0
    @State private var listItem:Int = 1
    @State private var alarmList = Array(repeating: "", count: 10)
    @State private var alarmListNum = [Int]()
    @State private var state:Bool = false
    @State private var save:Bool = false
    @Binding var alarm : Bool

    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm a"
        return formatter
        
    }
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm':'ss a"
        return formatter

    }
   
    
    init(alarm:Binding<Bool> = .constant(false)){
        _alarm = alarm
        
        
    }
    
    
    var body: some View{
        
        ZStack(alignment: .bottom){
            Section{
                
            VStack{
               
                Text(timeFormatter.string(from: currentDate)).font(.system(size: 30)).bold()
                           .onReceive(timer) { input in
                                self.currentDate = input
                                //print(timeFormatter.string(from: currentDate))
                            }
                
                ForEach(alarmList, id: \.self){ item in
                    if dateFormatter.string(from: currentDate) == item{
                            Text("일어나라").onAppear(){
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge,.sound,]){ success, error in
                                    if success{
                                        print("허용")
                                    }else if let error = error{
                                        print(error.localizedDescription)
                                    }
                                }
                                let content = UNMutableNotificationContent()
                                content.title = "일어나"
                                content.subtitle = "일어나야지"
                                content.sound = UNNotificationSound.default
                                let triger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                                let request = UNNotificationRequest(identifier: "req", content: content, trigger: triger)
                                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                self.state = true
                                if self.state{
                                    SoundSetting.instance.playSound(sound: .Opening)
                                }
                            
                            
                            }
                            
                        
                        }
                    
                }
              
                
                
                
                
                ZStack{
                    //Spacer().frame(height: 80)
                    Banner(icon: "alarm.fill", color: Color.blue, content: "알람").padding()
                    Button(action:{
                        alarmAdd.toggle()
                        if alarmAdd{
                            button = "minus.square.fill"
                        }else{
                            button = "plus.app.fill"
                        }
                        
                        //print(alarmAdd)
                        //SoundSetting.instance.playSound(sound: .Tada)
                    }){
                        Image(systemName: button).font(.system(size: 50)).foregroundColor(.white).padding(40).padding(.leading,250)
                    }
                
                }.listRowSeparator(.hidden)
                Spacer()
                
                if alarmAdd{
                    ZStack{
                        HStack{
                            Spacer()
                            VStack{
                                DatePicker("", selection: $wakeup,displayedComponents: .hourAndMinute).foregroundColor(.white)
                                    .datePickerStyle(WheelDatePickerStyle()).labelsHidden().padding()
                                Button(action: {

                                    pushTime = dateFormatter.string(from: wakeup)
                                    alarmList[item].append(pushTime)
                                    pushTime1 = alarmList[item]
                                    currentTime = timeFormatter.string(from: currentDate)
                                    alarmListNum.append(item)
                                    self.item += 1
                                    self.save = true
                                    
                                    //listItem += 1
                                }){
                                    Text("저장").font(.system(size: 30)).fontWeight(.black).foregroundColor(.white).padding(30)
                                }.alert(isPresented: $save){
                                    Alert(title: Text("알람이 저장 되었습니다!"))
                                }
                                    
                                


                                Spacer().frame(height:350)
                            }
                            
                            Spacer()
                        }.background(Color.blue).cornerRadius(20)
                        

                    }.padding().transition(.move(edge: .bottom))
                        .animation(.easeIn(duration: 0.2))
                    
                    
                }
                
                //if item > 0{
                    VStack{
                       List {
                            Section(header: Text("알람 목록")) {
                                ForEach(alarmList, id: \.self) { s in
                                    
//                                    if s == dateFormatter.string(from: current){
//                                        Text("일어나라")
//                                    }
                                    
                                
                                    ZStack{
                                        
                                        if s != ""{
                                            Banner(icon: "alarm.fill", color: Color.blue, content: "알람")
                                            HStack{
                                                Text(s).font(.system(size: 25)).foregroundColor(.white).padding(.leading,150).onAppear(){
                                                    //alarmList1 = alarmList
                                                    //print(alarmListNum[listItem])
                                                }
                                                
                                            
                                            Button(action: {
                                           
                                                if let firstIndex = alarmList.firstIndex(of: s) {
                                                    alarmList.remove(at: firstIndex)
                                                    alarmList.append("")
                                                    item -= 1
                                                }
                                                
                                                
                                            }){
                                                Text("삭제").foregroundColor(.blue).padding(5).background(Color.white).cornerRadius(10)
                                            }
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }

                            }
                            }
                        }
  
                    }

            }
            
        }
        
        }
   
    }
    
}
struct Alarm_Previews: PreviewProvider {
    static var previews: some View {
        Alarm()
    }
}

