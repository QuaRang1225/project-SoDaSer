//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct WoldTime:View{
    
    @Binding var worldTime  : Bool
    
    init(worldTime:Binding<Bool> = .constant(false)){
        _worldTime = worldTime
    }
    var body: some View{
        VStack{
            Banner(icon: "network", color: Color.green, content: "세계시계").padding()
            Spacer()
            Rectangle().foregroundColor(.green).cornerRadius(20).padding()
            
        }
    }
}
struct WorldTime_Previews: PreviewProvider {
    static var previews: some View {
        WoldTime()
    }
}
