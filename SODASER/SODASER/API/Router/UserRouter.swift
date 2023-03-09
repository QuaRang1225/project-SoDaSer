//
//  UserRouter.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/30.
//


import Foundation
import Alamofire

enum UserRouter:URLRequestConvertible{
    
    
    case users
    case userInfo
    case postList(email:String)
    case posting(title:String,catrgoryValue:String,diary:String,long:Double,lat:Double,image:String)
    case favorite(keyWord:String,city:String,location:String,lat:Double,long:Double,title:String,image:String)
    case favoriteResponse(keyword:String)
    case otherUser(email:String)
    var baseURL:URL{
        return URL(string: ApiClient.SODASER_SERVER_URL)!
    }
    
    var endPoint:String{
        switch self{
        case .users:    //전체유저정보
            return "/user/list"
        case .userInfo: //내 정보
            return "/user"
        case .posting:  //포스팅내용
            return "/post"
        case let .postList(email):
            return "/post/list/\(email)"
        case .favorite:
            return "/"
        case let .favoriteResponse(keyword):
            return "/\(keyword)"
        case let .otherUser(email):
            return "/user/\(email)"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .users, .userInfo, .postList,.favoriteResponse,.otherUser:
            return .get //세션 Id는 get
        case .posting,.favorite:
            return .post
        }
    }
    
    var parameters:Parameters{
        switch self{
        case .users,.userInfo, .postList,.favoriteResponse,.otherUser:
            return Parameters()
        case let .posting(title,catrgoryValue,diary,long,lat,image):
            var params = Parameters()
            params["title"] = title
            params["category"] = catrgoryValue
            params["contents"] = diary
            params["image"] = image
            params["longitude"] = long
            params["latitude"] = lat
            return params
        case let .favorite(keyWord,city,location,lat,long,title,image):
            var params = Parameters()
            params["keyWord"] = keyWord
            params["city"] = city
            params["location"] = location
            params["latitude"] = lat
            params["longitude"] = long
            params["title"] = title
            params["image"] = image
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)   //사용할 uri 결정  -> /login
        var request = URLRequest(url:url)   //해당 url 설정
        
        request.method = method //만들어준 메서드 적용
        switch self{
        case .users,.userInfo,.postList,.favoriteResponse,.otherUser:
            return request
        case .posting,.favorite:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
