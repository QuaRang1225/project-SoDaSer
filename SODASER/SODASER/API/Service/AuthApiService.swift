//
//  AuthApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/31.
//

import Foundation
import Alamofire
import Combine


//인증 관련 api 호출
enum AuthApiService{
    
    static let intercept = BaseIntercept()
    
    static func register(nickname:String,email:String,name:String,password:String,profileImageUrl:String)-> AnyPublisher<Register,AFError>{    //받아오는 데이터는 유저정보로 설정 이름,이메일,프로필 사진
        print("AuthAPiService - 토큰값 호출")
        return ApiClient.shared.session     //세션 접근
            .request(AuthRouter.register(nickname:nickname,name: name, email: email, password: password,profileImage:profileImageUrl))   //카카오토큰 요청/호출
            .publishDecodable(type:Register.self)
            .value()    //값만 가져오기
            .map{ receivedValue in
                print("받아온 데이터 : \(receivedValue)")
                return receivedValue.self
            }.eraseToAnyPublisher() //구독 취소
    }
    
    static func login(email:String,password:String)-> AnyPublisher<UserResponse,AFError>{    //받아오는 데이터는 유저정보로 설정 이름,이메일,프로필 사진
        print("AuthAPiService - 토큰값 호출")
        return ApiClient.shared.session     //세션 접근
            .request(AuthRouter.login(email: email, password: password))   //카카오토큰 요청/호출
            .publishDecodable(type:UserResponse.self)  
            .value()    //값만 가져오기
            .map{ receivedValue in
                print("받아온 데이터 : \(receivedValue)")
                //print("쿠키저장완료 \(String(describing: HTTPCookieStorage.shared.cookies))")
                UserDefaultManager.shared.save()     //받은 세션 Id 영구저장 - cookieStorage 저장소안에 저장
                return receivedValue.self   //UserDataModel의 값들 모두 반환
            }.eraseToAnyPublisher() //구독 취소
    }
    static func infoChange(nickname:String,email:String,name:String,imageUrl:String)-> AnyPublisher<UserData,AFError>{
        return ApiClient.shared.session
            .request(AuthRouter.infoChange(nickname: nickname, name: name, email: email, imagerUrl: imageUrl),interceptor: intercept)
            .publishDecodable(type: UserData.self)
            .value()
            .map { receivedValue in
                return receivedValue.self
            }.eraseToAnyPublisher()
    }
}


