//
//  InfoFilter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/06.
//

import Foundation

enum InfoFilter{
    case name
    case nickname
    
    var title:String{
        switch self{
        case .name:
            return "이름"
        case .nickname:
            return "닉네임"
        }
    }
}
