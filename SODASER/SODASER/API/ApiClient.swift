//
//  ApiClient.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

//싱글톤
//Api 호출 클라이언트
final class ApiClient{
    
    
    var session:Session //AF와 같은 역할
    static let shared = ApiClient() //무조건 싱글톤 - 메모리 관리 효율적으로 사용하기 위해
    static let SODASER_SERVER_URL = "http://sodaseo-api.creboring.net"
    let moniters = [ApiLogger()] as [EventMonitor]      //api 호출 모니터링
    
    //let intercepters = Interceptor(interceptors: [ AuthInterceptor()]) //application/json])
    
    init(){
        //session = Session(interceptor: intercepters,eventMonitors: moniters)    //세션에 헤더 내용 추가 및 모니터링
        session = Session(eventMonitors: moniters)
        print("AppiClient가 생성되었음 \(session)")
    }
}
