//
//  UIApplication.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import Foundation
import SwiftUI


extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }   //키보드 dismissing
}
