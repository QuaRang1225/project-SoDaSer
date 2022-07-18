
//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct Alarm1:View{
    
    @State var alarmAdd: Bool = false
    @State private var wakeup = Date()
    @State private var pushTime=String()
    @State private var pushTime1=String()
    @State private var item:Int = 0
    @State private var alarmList = Array(repeating: "", count: 10)
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
                VStack{
                    Spacer().frame(height: 80)
                    ZStack{
                        
                        Banner(icon: "alarm.fill", color: Color.blue, content: "알람").padding()
                        Button(action:{
                            alarmAdd.toggle()
                        }){
                            Image(systemName: "plus.app.fill").font(.system(size: 50)).foregroundColor(.white).padding(40).padding(.leading,250)
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
                                        
                                        
                                        
                                    }){
                                        Text("저장").font(.system(size: 30)).fontWeight(.black).foregroundColor(.white).padding(30)
                                    }
                                    
                                    
                                    
                                    Spacer().frame(height:350)
                                }
                                Spacer()
                            }.background(Color.blue).cornerRadius(20)
                            
                            
                        }.padding().transition(.move(edge: .bottom))
                            .animation(.easeIn(duration: 0.2))
                        

                    }
                    
                    //Section{
                        //ForEach(alarmList, id: \.self){ i in
                            //Text(alarmList[item])
                        //}
                        
                        
                    //}
                  
//                    if item != 10{
//                        VStack{
//                            Text(pushTime1)
//                        }
//
//                    }
                    
                    Spacer()
                        
                }
                    
                
            }.ignoresSafeArea()
        }
    
}
struct Alarm1_Previews: PreviewProvider {
    static var previews: some View {
        Alarm1()
    }
}
