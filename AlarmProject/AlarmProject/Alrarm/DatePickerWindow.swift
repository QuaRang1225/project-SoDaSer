//
//  DatePicker.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI
import UserNotifications
import UserNotificationsUI
import AVKit
import AVFoundation





struct DatePickerWindow:View{
    
    @State private var wakeup = Date()
    @State private var save:Bool = false
    @State private var pushTime=String()
    @State private var pushTimeString=String()
    @State private var alarmList:Array<String> = []
    @State private var alarmListInterval:Array<Int> = []
    @State private var item:Int = 0
    @State private var currentTime=String()
    @State var content: String = ""
    @State var currentDate = Date()
    
    @Environment(\.managedObjectContext) var mac
    //@Environment(\.managedObjectContext) var mac1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    
   
    var body: some View{
        VStack{
            Spacer().frame(height: 20)
            DatePicker("", selection: $wakeup,displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle()).labelsHidden().padding().background(Color.indigo).cornerRadius(20)
            VStack {
                Text("알람의 이름을 입력하세요").foregroundColor(.indigo).font(.system(size: 20)).fontWeight(.black)
                TextField("", text: $content)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
            
            
            }.padding().background(.white).cornerRadius(20)
                
            Button(action: {

                
                alarmList.append(FormatterClass.init().dateFormatter.string(from: wakeup))
                currentTime = FormatterClass.init().yearsettingFormatter.string(from: wakeup)
                pushTimeString = alarmList[item]
                alarmList.sort()
                
             
                self.item += 1
                self.save = true
                
                let time = Entity(context:mac)
                time.alarmText = content
                time.time = pushTimeString
                try? mac.save()



                var useTime:Int
                guard let startTime:Date = FormatterClass.init().yearFormatter.date(from: FormatterClass.init().yearFormatter.string(from: currentDate)) else {return}
                guard let endTime:Date = FormatterClass.init().yearsettingFormatter.date(from: self.currentTime)  else {return}
                
                if startTime >= endTime{
                    useTime = Int((endTime + 86400).timeIntervalSince(startTime))-4
                }else{
                    useTime = Int(endTime.timeIntervalSince(startTime))-4
                }
                
                alarmListInterval.append(useTime)
                alarmListInterval.sort()
                

                print(startTime)
                print(endTime+86400)
                print(useTime)
                print(alarmList)
                
                
                
                AlertAlarm().alertalram(timeinterval: alarmListInterval[alarmListInterval.count-1],listName: content ,listTime: String(FormatterClass.init().dateFormatter.string(from: wakeup)))
 
    
            }){
                Text("저장").font(.system(size: 30)).fontWeight(.black).foregroundColor(.indigo).padding(30)
            }.alert(isPresented: $save){
                Alert(title: Text("알람이 저장 되었습니다!"))
            }
            
            Spacer().frame(height:80)
        }
    }
}
struct DatePickerWindow_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerWindow()
    }
}
