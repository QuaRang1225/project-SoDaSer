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
        
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
            VStack{
                Banner(icon: "timer",  color: Color.white,content: "타이머").padding(.bottom)
                
                TimerWindow().cornerRadius(20)
                
                
            }.padding()
        }
        
    }
}
struct TimerCount_Previews: PreviewProvider {
    static var previews: some View {
        TimerCount()
    }
}
