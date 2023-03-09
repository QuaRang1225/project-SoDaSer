//
//  ApiLogger.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire

final class ApiLogger:EventMonitor{
    
    let queue =  DispatchQueue(label: "SODASER")
    
    //api 호출 시
    func requestDidResume(_ request: Request) {
        print("API 재개 : \(request)")
    }
    //api 호출 종료 시
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("API 종료 : \(request)")
    }
}
