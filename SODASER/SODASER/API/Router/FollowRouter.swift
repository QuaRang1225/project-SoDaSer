//
//  PostRouter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/13.
//

import Foundation
import Alamofire

enum FollowRouter:URLRequestConvertible{
    
    
    case follow(targetUser:String)
    case followingList(email:String)
    case followerList(email:String)
    
    var baseURL:URL{
        return URL(string: ApiClient.SODASER_SERVER_URL)!
    }
    
    var endPoint:String{
        switch self{
        case .follow:
            return "/user/follow"
        case let .followerList(email):
            return "/user/follower/list/\(email)"
        case let .followingList(email):
            return "/user/follow/list/\(email)"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .follow:
            return .post
        case .followerList,.followingList:
            return .get
        }
    }
    
    var parameters:Parameters{
        switch self{
        case let .follow(targetUser):
            var params = Parameters()
            params["targetUser"] = targetUser
            return params
        case .followerList,.followingList:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)   //사용할 uri 결정  -> /login
        var request = URLRequest(url:url)   //해당 url 설정
        
        request.method = method //만들어준 메서드 적용
        switch self{
        case .followerList,.followingList:
            return request
        case .follow:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
