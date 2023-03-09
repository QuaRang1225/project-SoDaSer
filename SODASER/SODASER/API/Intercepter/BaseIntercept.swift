//
//  BaseIntercept.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//


import Foundation
import Alamofire

class BaseIntercept:RequestInterceptor{
    
    //api 호출시 값을 중간에 수정/변경해주는 Operaition
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest
        if let cookies = UserDefaults.standard.value(forKey: "cookies") as? [[HTTPCookiePropertyKey : Any]] {
            for cookie in cookies {
                if let oldCookie = HTTPCookie(properties: cookie) {
                    HTTPCookieStorage.shared.setCookie(oldCookie)
                    request.headers.add(name: "Cookie", value: "\(oldCookie)") //헤더 값
                    completion(.success(request))       //성공 시 url 요청
                }
            }
        }
    }
}
