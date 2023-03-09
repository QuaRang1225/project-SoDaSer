//
//  UserDefalutManager.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/16.
//

import Foundation

class UserDefaultManager{   //데이터 영구저장
    
    static let shared = UserDefaultManager()
    
    
    func save(){
        var cookies = [Any]()
        if let newCookies = HTTPCookieStorage.shared.cookies {
            for newCookie in newCookies {
                var cookie = [HTTPCookiePropertyKey : Any]()
                cookie[.name] = newCookie.name
                cookie[.value] = newCookie.value
                cookie[.domain] = newCookie.domain
                cookie[.path] = newCookie.path
                cookie[.version] = newCookie.version
                if let date = newCookie.expiresDate {
                    cookie[.expires] = date
                }
                cookies.append(cookie)
                
            }
            UserDefaults.standard.setValue(cookies, forKey: "cookies")
            UserDefaults.standard.synchronize()
        }
        
    }
    func restore(){
        if let cookies = UserDefaults.standard.value(forKey: "cookies") as? [[HTTPCookiePropertyKey : Any]] {
            for cookie in cookies {
                if let oldCookie = HTTPCookie(properties: cookie) {
                    print("cookie loaded:\(oldCookie)")
                    HTTPCookieStorage.shared.setCookie(oldCookie)
                }
            }
        }
    }
    
}
