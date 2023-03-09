//
//  ColorSet.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import Foundation
import SwiftUI


extension Color{
    
    static var whiteCyan = Color("whitecyan")
    static var antiPrimary = Color("BW")
    static var blackIndigo = Color("blackIndigo")
    static var whiteCyan2 = Color("whitecyan2")
    static var cyanindigo = Color("cyanindigo")
    static var whiteGray = Color("whiteGray")
    
    static func sodaserSet(_ color:String) -> some  View{
        Image(color)
            .resizable()
            .frame(width:100,height:30)
    }
}

extension View {    //네비게이션 타이틀바 색 지정

    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}
