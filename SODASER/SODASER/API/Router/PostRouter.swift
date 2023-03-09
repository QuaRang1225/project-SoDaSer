//
//  PostRouter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/13.
//

import Foundation
import Alamofire

enum PostRouter:URLRequestConvertible{
    
    
    case reply(text:String,endPoint:String)
    case heart(heart:Bool,endPoint:String)
    case feed
    
    var baseURL:URL{
        return URL(string: ApiClient.SODASER_SERVER_URL)!
    }
    
    var endPoint:String{
        switch self{
        case let .reply(_,endPoint):
            return "\(endPoint)"
        case let .heart(_,endPoint):
            return "\(endPoint)"
        case .feed:
            return "/feed"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .reply,.heart:
            return .post
        case .feed:
            return .get
        }
    }
    
    var parameters:Parameters{
        switch self{
        case .feed:
            return Parameters()
        case let .heart(heart,_):
            var params = Parameters()
            params[""] = heart
            return params
        case let .reply(text,_):
            var params = Parameters()
            params[""] = text
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)   //사용할 uri 결정  -> /login
        var request = URLRequest(url:url)   //해당 url 설정
        
        request.method = method //만들어준 메서드 적용
        switch self{
        case .feed:
            return request
        case .heart,.reply:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
