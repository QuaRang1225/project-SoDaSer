//
//  UserApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/30.
//

import Foundation
import Alamofire
import Combine

enum FollowApiService{
    
    static let interceptor = BaseIntercept()
    
    static func followingList(email:String)->AnyPublisher<[UserData],AFError>{
        return ApiClient.shared.session
            .request(FollowRouter.followingList(email: email),interceptor: interceptor)
            .publishDecodable(type:[UserData].self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func followerList(email:String)->AnyPublisher<[UserData],AFError>{
        return ApiClient.shared.session
            .request(FollowRouter.followerList(email: email),interceptor: interceptor)
            .publishDecodable(type:[UserData].self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
    static func follow(targetUser:String)->AnyPublisher<Follow,AFError>{
        return ApiClient.shared.session
            .request(FollowRouter.follow(targetUser: targetUser),interceptor: interceptor)
            .publishDecodable(type: Follow.self)
            .value()
            .map{ receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
    

    
    
}
