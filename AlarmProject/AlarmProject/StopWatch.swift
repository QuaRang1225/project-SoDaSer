//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct StopWatch:View{
    
    @Binding var stopwatch  : Bool
    
    init(stopwatch:Binding<Bool> = .constant(false)){
        _stopwatch = stopwatch
    }
    var body: some View{
        VStack{
            Banner(icon: "stopwatch.fill", color: Color.red, content: "스톱워치").padding()
            Rectangle().foregroundColor(.red).cornerRadius(20).padding()
        }

    }
}
struct StopWatch_Previews: PreviewProvider {
    static var previews: some View {
        StopWatch()
    }
}
