//
//  ImageSet.swift
//  SODASER
//
//  Created by 유영웅 on 2022/12/29.
//

import Foundation
import SwiftUI

struct DummyCircle:View{
    
    let width:Double
    let height:Double
    
    var body: some View{
        Circle()
            .frame(width: width,height: height)
            .scaledToFit()
            .foregroundColor(.gray.opacity(0.5))
            .opacity(0.5)
            .overlay{
                Image(systemName: "person.circle.fill")
                    .resizable().foregroundColor(.cyan.opacity(0.5))
            }
    }
        
}
struct DummyCircle_PreView:PreviewProvider{
    static var previews: some View {
        DummyCircle(width: 100, height: 100)
    }
}
