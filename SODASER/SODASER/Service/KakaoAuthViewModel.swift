////
////  KakaoAuthViewModel.swift
////  SODASER
////
////  Created by 유영웅 on 2022/10/19.
////
//
//import Foundation
//import SwiftUI
//import Combine
//import KakaoSDKAuth
//import KakaoSDKUser
//
//class KaKaoAuthViewModel:ObservableObject{
//
//    var sendKakaoToken = PassthroughSubject<Void,Never>()
//    @Published var isLogedIn :Bool = false
//    @Published var token:TokenData? = nil
//
//    @MainActor
//    func kakoLogout(){  //로그아룻 버튼
//        Task{
//            if await handleKakaoLogout(){
//                withAnimation(.easeOut(duration: 1.0)){
//                    self.isLogedIn = false
//                }
//            }
//        }
//    }
//    func handleKakaoLogout() async -> Bool{
//        await withCheckedContinuation{ continuation in
//            UserApi.shared.logout {(error) in
//                if let error = error {
//                    print(error)
//                    continuation.resume(returning: false)
//                }
//                else {
//                    print("logout() success.")
//                    continuation.resume(returning: true)
//                }
//            }
//        }
//    }
//    func handleKakaoLoginWithKakao() async -> Bool{
//        //카카오 앱에서 로그인적용 - 설치 되어있을때
//        await withCheckedContinuation{ continuation in
//            print("카카오톡 로그인 \(continuation)")
//            UserApi.shared.loginWithKakaoTalk { [self] (oauthToken, error) in
//                accessTokenWithKakao(continuation: continuation, oauthToken: oauthToken!, error: error)
//            }
//        }
//    }
//    func handleWithKakaoAccount() async -> Bool{
//        //카카오 웹뷰에서 로그인적용 - 설치 안 되어있을때
//        await withCheckedContinuation{ continuation in
//            UserApi.shared.loginWithKakaoAccount { [self]  (oauthToken, error) in
//                   accessTokenWithKakao(continuation: continuation, oauthToken: oauthToken!, error: error)
//            }
//        }
//    }
//    func accessTokenWithKakao(continuation: CheckedContinuation<Bool, Never>,oauthToken:OAuthToken,error:Error?){
//        if let error = error {
//            print(error)
//            continuation.resume(returning: false)
//        }
//        else {
//
//            print("loginWithKakaoAccount() success.")
//            //do something
//            _ = oauthToken
//            //token = TokenData(refreshToken: oauthToken.refreshToken, accessToken: oauthToken.accessToken)
//            //print("최종 보내준 값 : \(token!)")
//            continuation.resume(returning: true)
//            self.sendKakaoToken.send()
//
//            DispatchQueue.main.async {
//                withAnimation(.easeOut(duration: 1.0)){
//                    self.isLogedIn = true
//                }
//            }
//
//        }
//    }
//
//
//    @MainActor
//    func handleKakaoLogin(){
//        Task{
//            // 카카오톡 설치 여부 확인
//                if (UserApi.isKakaoTalkLoginAvailable()) {
//                    isLogedIn =  await handleKakaoLoginWithKakao()
//                }
//                else{
//                    isLogedIn = await handleWithKakaoAccount()
//
//            }
//        }
//    }
//}
