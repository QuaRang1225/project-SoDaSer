//
//  StopWatchButton.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/08/01.
//

import Foundation
import SwiftUI

struct StopWatchButton:View{
    
    @State var image = String()
    
    var body: some View{
        
        Image(systemName: image).font(.system(size: 50)).foregroundColor(.indigo)
            
        
    }
}

struct StopWatchButton_Previews: PreviewProvider {
static var previews: some View {
    StopWatchButton(image: "stop.fill")
}
}

