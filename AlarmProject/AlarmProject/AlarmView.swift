//
//  AlarmView.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/16.
//

import Foundation
import SwiftUI


struct AlarmView: View {
    
    @State private var wakeup = Date()
    @State private var saveAlarm:Bool = false
    @State public var pushTime=String()
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm"
        return formatter
        
    }
    
    var body:some View{
        ZStack{
            HStack{
                Spacer()
                VStack{
                    DatePicker("", selection: $wakeup,displayedComponents: .hourAndMinute).foregroundColor(.white)
                                //date피커스타일 에 .lablesHidden()을 사용하면 피커에 텍스트가 안보이게됨
                        .datePickerStyle(WheelDatePickerStyle()).labelsHidden().padding()
                    Button{
                        //saveAlarm.toggle()
                        pushTime = dateFormatter.string(from: wakeup)
                        
                    }label: {
                        Text("저장").font(.system(size: 30)).fontWeight(.black).foregroundColor(.white).padding(30)
                    }
                    Text(pushTime)
                    
                    
                    Spacer().frame(height:300)
                }
                Spacer()
            }.background(Color.blue).cornerRadius(20)
            
            
        }
        
    }
    
}
struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
