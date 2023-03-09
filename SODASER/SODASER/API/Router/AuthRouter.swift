//
//  AuthRouter.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

//인증라우터
enum AuthRouter:URLRequestConvertible{
    
    //url 요청을 만들어주는 단계
    
    //url 요청시 전송할 토큰섹션
    case login(email:String,password:String)
    case register(nickname:String,name:String,email:String,password:String,profileImage:String)
    case infoChange(nickname:String,name:String,email:String,imagerUrl:String)
    
    //사용할 URL 입력
    var baseURL:URL{
        return URL(string: ApiClient.SODASER_SERVER_URL)!
    }
    
    var endPoint:String{    //특정 메서드 사용시 보낼 uri
        switch self{
        case .login:
            return "/login"
        case .register:
            return "/user/register"
        case .infoChange:
            return "/user"
        }
    }
    
    var method:HTTPMethod{  //어떤 api를 타느냐에 따라 설정
        switch self{
        case .infoChange:
            return .patch
        default:return .post
        }
    }
    
    var parameters:Parameters{  //사용하는 라우터(로그인,회원가입 등)에 따라서 어떤 파라미터를 보낼건지 세팅
        switch self{
        case let .register(nickname,name, email, password,profileImage):
            var params = Parameters() //[String:Any]
            params["nickname"] = nickname //특정필드에 case에 대한 값 적용
            params["name"] = name
            params["email"] = email
            params["password"] = password
            params["profileImage"] = profileImage
            return params
            
        case let .login(email,password):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            return params
            
        case let .infoChange(nickname, name, email,imageUrl):
            var params = Parameters() //[String:Any]
            params["nickname"] = nickname //특정필드에 case에 대한 값 적용
            params["name"] = name
            params["email"] = email
            params["profileImage"] = imageUrl
            return params
        }
    }
    
    //URLRequestConvertible을 반환하기 위한 메서드 -> 만들어진 uri로 api를 호출
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)   //사용할 uri 결정  -> /login
        var request = URLRequest(url:url)   //해당 url 설정
        
        request.method = method //만들어준 메서드 적용
        print("과연 보내는 파라미터의 값은?!! -> \(try URLEncoding.default.encode(request, with: parameters))")
        //request.httpBody
        return try URLEncoding.default.encode(request, with: parameters)    //json으로 인코딩하여 http서버의 body로 전달
        //URLEncoding / JSONEncoding 차이
    }
}
