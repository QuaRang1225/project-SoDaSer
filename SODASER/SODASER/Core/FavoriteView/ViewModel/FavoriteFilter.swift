//
//  FavoriteFilter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import Foundation

enum FavoriteFilter:Int,CaseIterable{
    case food
    case coffee
    case play
    case bus
    case bed
    case shoping
    case parking
    case shower
    case park
    case bank
    case heart
    case hospital
    
    var imageName:String{
        switch self{
        case .food:
            return "fork.knife"
        case .coffee:
            return "cup.and.saucer.fill"
        case .play:
            return "party.popper.fill"
        case .bus:
            return "bus"
        case .bed:
            return "bed.double.fill"
        case .shoping:
            return "cart.fill"
        case .parking:
            return "parkingsign.circle.fill"
        case .shower:
            return "shower.fill"
        case .park:
            return "camera.macro"
        case .bank:
            return "dollarsign.circle.fill"
        case .heart:
            return "heart.fill"
        case .hospital:
            return "cross.fill"
        }
    }
    var title:String{
        switch self{
        case .food:
            return "식사"
        case .coffee:
            return "카페"
        case .play:
            return "재미"
        case .bus:
            return "교통"
        case .bed:
            return "숙소"
        case .shoping:
            return "쇼핑"
        case .parking:
            return "주차장"
        case .shower:
            return "목욕"
        case .park:
            return "공원"
        case .bank:
            return "은행"
        case .heart:
            return "편의"
        case .hospital:
            return "병원"
        }
    }
}
