//
//  AlramList.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/16.
//

import Foundation
import SwiftUI

struct AlarmList:View{
    var time:String
    var content:String

    var body: some View{

            ZStack{
                Banner(icon: "alarm.fill",  color: Color.white,content: self.content)
                Text(time).font(.system(size: 25)).foregroundColor(.indigo).padding(.leading,160)
            }
            
        
    }
}
struct AlarmList_Previews: PreviewProvider {
    static var previews: some View {
        AlarmList(time: "d",content: "안녕")
    }
}
