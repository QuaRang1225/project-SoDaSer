//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct TimerCount:View{
    
    @Binding var timer  : Bool
    
    init(timer:Binding<Bool> = .constant(false)){
        _timer = timer
    }
    var body: some View{
        VStack{
            Banner(icon: "timer",  color: Color.white,content: "타이머").padding()
            
            Text("d").font(.system(size: 30)).foregroundColor(.indigo).fontWeight(.bold).padding()
                       
            Spacer().frame(height: 20)
            Rectangle().foregroundColor(.indigo).frame(width: 75, height: 20).cornerRadius(5)
            Rectangle().foregroundColor(.indigo).frame(width: 200, height: 300).cornerRadius(20)
            
            
        }
    }
}
struct TimerCount_Previews: PreviewProvider {
    static var previews: some View {
        TimerCount()
    }
}
