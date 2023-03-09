//
//  UserApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/30.
//

import Foundation
import Alamofire
import Combine

enum UserApiService{
    
    static let interceptor = BaseIntercept()
    
    static func otherUser(email:String)->AnyPublisher<UserData,AFError>{
        return ApiClient.shared.session
            .request(UserRouter.otherUser(email:email),interceptor: interceptor)
            .publishDecodable(type:UserData.self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }
    static func userInfo()->AnyPublisher<UserData,AFError>{
        return ApiClient.shared.session
            .request(UserRouter.userInfo,interceptor: interceptor)
            .publishDecodable(type:UserData.self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }
    static func usersInfo()->AnyPublisher<[UserData],AFError>{
        return ApiClient.shared.session
            .request(UserRouter.users,interceptor: interceptor)
            .publishDecodable(type:[UserData].self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }
    static func posting(title:String,catergoryValue:String,diary:String,long:Double,lat:Double,image:String)->AnyPublisher<PostResponse,AFError>{
        return ApiClient.shared.session
            .request(UserRouter.posting(title: title, catrgoryValue: catergoryValue, diary: diary, long: long, lat: lat,image: image),interceptor: interceptor)
            .publishDecodable(type:PostResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }
    static func postList(email:String)->AnyPublisher<[Post],AFError>{
        return ApiClient.shared.session
            .request(UserRouter.postList(email: email),interceptor: interceptor)
            .publishDecodable(type: [Post].self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }
            .eraseToAnyPublisher()
    }
    static func favorite(keyWord:String,city:String,location:String,lat:Double,long:Double,title:String,image:String)->AnyPublisher<FavoriteResponse,AFError>{
        return ApiClient.shared.session
            .request(UserRouter.favorite(keyWord: keyWord, city: city, location: location, lat: lat, long: long,title:title,image:image))
            .publishDecodable(type: FavoriteResponse.self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }
    static func favoriteResponse(keyWord:String)->AnyPublisher<[Favorite],AFError>{
        return ApiClient.shared.session
            .request(UserRouter.favoriteResponse(keyword: keyWord))
            .publishDecodable(type: [Favorite].self)
            .value()
            .map{ receivedValue in
                return receivedValue
            }.eraseToAnyPublisher()
    }

    
    
}
