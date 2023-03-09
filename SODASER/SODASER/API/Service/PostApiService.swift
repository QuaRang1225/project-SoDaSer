//
//  PostApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/13.
//

import Foundation
import Combine
import Alamofire

enum PostApiService{
    
    static let interceptor = BaseIntercept()
    
    static func reply(text:String,endPoint:String) -> AnyPublisher<Reply,AFError>{
        return ApiClient.shared.session
            .request(PostRouter.reply(text: text,endPoint:endPoint))
            .publishDecodable(type: Reply.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
            
    }
    
    static func heart(heart:Bool,endPost:String) -> AnyPublisher<Heart,AFError>{
        return ApiClient.shared.session
            .request(PostRouter.heart(heart: heart, endPoint: endPost))
            .publishDecodable(type: Heart.self)
            .value()
            .map { receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
    static func feed() -> AnyPublisher<[Feed],AFError>{
        return ApiClient.shared.session
            .request(PostRouter.feed,interceptor: interceptor)
            .publishDecodable(type: [Feed].self)
            .value()
            .map { receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
    
}
