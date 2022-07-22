//
//  Banner.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct Banner:View{
    
    var icon:String
    public var color:Color
    var content:String
    
    var body: some View{
        HStack{
            Image(systemName: icon).font(.system(size: 50)).foregroundColor(.white)
            Text(content).foregroundColor(.white).font(.system(size: 25)).fontWeight(.black)
            Spacer()
        }.padding().background(color).cornerRadius(20)
    }
    
}
struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner(icon: "alarm.fill", color: Color.green, content: "세계시계")
    }
}

