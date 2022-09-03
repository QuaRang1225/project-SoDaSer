//
//  ClcokWindow.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/08/09.
//

import Foundation
import SwiftUI

struct Time{
    var hour :Int
    var minute:Int
    var second:Int
}

struct ClockWindow:View{
    
    var width  = UIScreen.main.bounds.width
    @State var currentTime = Time(hour: 0, minute: 0, second: 0)
    @State var timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    @State var currentDate = Date()
    
    var body: some View{
        VStack{
            Spacer()
           // Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "").font(.largeTitle).foregroundColor(.indigo)                .fontWeight(.black)                .padding(.top, 40)
                HStack{
                    Spacer()
                    ZStack{
                        Image("NIGHT")
                            .frame(width: width - 100,height: width - 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.indigo,lineWidth: 5).padding(-5)).padding()
                        ForEach(0..<60, id: \.self){ i in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 2,height: (i % 5) == 0 ? 12 : 5)
                                .offset(y: (width - 110)/2)
                                .rotationEffect(.init(degrees: Double(i * 6)))
                        }
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 2,height: (width - 180)/2)
                            .offset(y: -(width - 180)/4)
                            .rotationEffect(.init(degrees: Double(currentTime.second * 6)))
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 4,height: (width - 200)/2)
                            .offset(y: -(width - 200)/4)
                            .rotationEffect(.init(degrees: Double(currentTime.minute * 6)))
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 4.5,height: (width - 240)/2)
                            .offset(y: -(width - 240)/4)
                            .rotationEffect(.init(degrees: Double(currentTime.hour * 30)))
                        Circle()
                            .fill(Color.white)
                            .frame(width: 15,height: 15)
                        
                    }
                    
                    Spacer()
                    
                }.onAppear(perform: {
                    let calender = Calendar.current
                    
                    let hour = calender.component(.hour, from: currentDate)
                    let min = calender.component(.minute, from: currentDate)
                    let sec = calender.component(.second, from: currentDate)
                    
                    withAnimation(Animation.linear(duration: 0.01)){
                        self.currentTime = Time(hour: hour, minute: min, second: sec)
                    }
                })
                .onReceive(timer){ _ in
                    let calender = Calendar.current
                    
                    let hour = calender.component(.hour, from: currentDate)
                    let min = calender.component(.minute, from: currentDate)
                    let sec = calender.component(.second, from: currentDate)
                    
                    withAnimation(Animation.linear(duration: 0.01)){
                        self.currentTime = Time(hour: hour, minute: min, second: sec)
                    }
                    
                }
            Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "").font(.largeTitle).foregroundColor(.indigo)                .fontWeight(.black)                .padding(.top, 40)
            Text(FormatterClass.init().dateFormatter.string(from: currentDate)).font(.system(size: 40)).fontWeight(.black).foregroundColor(.indigo)
                       .onReceive(timer) { input in
                            self.currentDate = input
                           
                       }
            Spacer()
        }.background(Color.white)
        
        
    }
}

struct ClockWindow_Previews: PreviewProvider {
    static var previews: some View {
        ClockWindow()
    }
}
