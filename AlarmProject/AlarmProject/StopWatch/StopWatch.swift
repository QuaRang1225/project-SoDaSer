//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct StopWatch:View{
    
    @Binding var stopWatch  : Bool
    
    init(stopWatch:Binding<Bool> = .constant(false)){
        _stopWatch = stopWatch
    }
    var body: some View{
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
            VStack{
                Banner(icon: "stopwatch.fill", color: Color.white, content: "스톱워치")
                Spacer().frame(height: 20)
                HStack{
                    Spacer()
                    StopWatchWindow()
                    Spacer()
                }.background(Color.white).cornerRadius(20)
            }.padding()
        }
        
    }
}
struct StopWatch_Previews: PreviewProvider {
    static var previews: some View {
        StopWatch()
    }
}
