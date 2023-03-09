//
//  PostFilter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/18.
//

import Foundation

enum PostFilter:Int,CaseIterable{
    case photo
    case map
    
    var titile:String{
        switch self{
        case .photo: return "square.grid.3x3"
        case .map: return "map"
        }
    }
}
