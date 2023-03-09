//
//  CustomModifier.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/15.
//

import Foundation
import SwiftUI

struct CustiomModifier:ViewModifier{
    let width:Double
    let height:Double
    let radius:Double?
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: width,height: height)
            .cornerRadius(radius ?? 0)
    }
}
