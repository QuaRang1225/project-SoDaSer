//
//  FollowFilter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/02.
//

import Foundation

enum FollowFilter:Int,CaseIterable{
    
    case follower
    case following
    
    var mode:String{
        switch self{
        case .follower:
            return "팔로워"
        case .following:
            return "팔로잉"
        }
    }
}
