//
//  CategoryOption.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/09.
//

import Foundation
import SwiftUI


enum PostCatrgory:Int,CaseIterable{
    case unknown
    case animal
    case travel
    case sports
    case internet
    case family
    case day
    case business
    case play
    
    var title:String{
        switch self{
        case .unknown:
            return "없음"
        case .animal:
            return "반려동물"
        case .travel:
            return "여행/맛집"
        case .sports:
            return "스포츠"
        case .internet:
            return "IT/인터넷"
        case .family:
            return "가족"
        case .business:
            return "기업/사업"
        case .play:
            return "게임/놀이"
        case .day:
           return "기념일"
        }
    }
}
