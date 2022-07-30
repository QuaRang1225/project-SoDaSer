//
//  LLL.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/30.
//

import Foundation
import SwiftUI

struct LLL: View {
    @State private var animationAmount = false

    var body: some View {
        VStack{
//            Button("Tap Me") {
//                // self.animationAmount += 1
//            }
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
            
            Image("NIGHT")
                .frame(width:200,height: 200)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 10, x: 0, y: 40)
                .overlay(Circle().stroke(Color.white.opacity(0.3),lineWidth: 5).padding(5))
                .overlay(Circle().stroke(Color.indigo,lineWidth: 5).padding(-5))
            
                    //.stroke(Color.red)
                    //.scaleEffect(animationAmount)
                .opacity(animationAmount ? 1.0 : 0.5)
            
                    
        }
        
    }
}
struct LLL_Previews: PreviewProvider {
    static var previews: some View {
        LLL()
    }
}
