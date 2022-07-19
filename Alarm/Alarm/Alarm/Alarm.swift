
//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI



struct Alarm:View{
    
    let runLoop = RunLoop.main
    @State var alarmAdd: Bool = false
    @State var button:String = "plus.app.fill"
    @State private var wakeup = Date()
    @State private var current = Date()
    @State private var pushTime=String()
    @State private var currentTime=String()
    @State private var pushTime1=String()
    @State private var item:Int = 0
    @State private var alarmList = Array(repeating: "", count: 10)
    @State private var state:Bool = false
    @Binding var alarm : Bool

    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm"
        return formatter
        
    }
   
    
    init(alarm:Binding<Bool> = .constant(false)){
        _alarm = alarm
        
        
    }
    
    
    var body: some View{
        
        ZStack(alignment: .bottom){
            Section{
                
            VStack{
                
                Text(currentTime)
                
                
                ZStack{
                    Spacer().frame(height: 80)
                    Banner(icon: "alarm.fill", color: Color.blue, content: "알람").padding()
                    Button(action:{
                        alarmAdd.toggle()
                        if alarmAdd{
                            button = "minus.square.fill"
                        }else{
                            button = "plus.app.fill"
                        }
                        print(alarmAdd)
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
                                    
    //
                                    self.item += 1
                                }){
                                    Text("저장").font(.system(size: 30)).fontWeight(.black).foregroundColor(.white).padding(30)
                                }.transition(.move(edge: .bottom))
                                    .animation(.easeIn(duration: 0.2))
                                


                                Spacer().frame(height:350)
                            }
                            
                            Spacer()
                        }.background(Color.blue).cornerRadius(20)
                        

                    }.padding().transition(.move(edge: .bottom))
                        .animation(.easeIn(duration: 0.2))
                    
                    
                }
                
                if item > 0{
                    VStack{
                        List {
                            Section(header: Text("알람 목록")) {
                                ForEach(alarmList, id: \.self) { s in
                                    if s == dateFormatter.string(from: current){
                                        Text("일어나라")
                                    }
                                HStack{
                                    ZStack{
                                        if s != ""{
                                            Banner(icon: "alarm.fill", color: Color.blue, content: "알람")
                                            Text(s).font(.system(size: 25)).foregroundColor(.white).padding(.leading,250)
                                        }
                                        
                                        
                                    }
                                    
                                }
                                    
                                    
                                //AlarmList(pushTime1: self.$pushTime1).padding()
                            }
                            }
                        }
  
                    }
                }
                
                
            }
                
        }
    }
        
        
//        List{
//            Section(header: ZStack{
//
//
//            }.listRowSeparator(.hidden)){
//
//            }
//            ZStack(alignment: .bottom){
//                VStack{
//
//
//
//                    Spacer()
//
//
//
//
//                    Spacer()
//
//                    if item > 0{
//
//                        Section{
//                            AlarmList(pushTime1: self.$pushTime1).padding()
//                            AlarmList(pushTime1: self.$pushTime1).padding()
//                        }
//
//                    }
//
//
//                    //
//                            //self.item += 1
//
////                    if item != 10{
////                        VStack{
////                            Text(pushTime1)
////                        }
////
////                    }
//
//                }
//
//
//            }.ignoresSafeArea()
//        }
//
//
    }
    
}
struct Alarm_Previews: PreviewProvider {
    static var previews: some View {
        Alarm()
    }
}

