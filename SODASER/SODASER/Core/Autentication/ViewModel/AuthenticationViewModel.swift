//
//  AuthenticationViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/02.
//
import Firebase
import Foundation
import Alamofire
import Combine
import UIKit


class AuthenticationViewModel:ObservableObject{
    
    var cancellable = Set<AnyCancellable>()
    var registerSuccess = PassthroughSubject<Bool,Never>()
    var alret = PassthroughSubject<(),Never>()
    var profileChange = PassthroughSubject<(),Never>()
    var infoChanges = PassthroughSubject<(),Never>()
    
    @Published var setProfileSuccess = false    //프로필 사진 선택 성공
    @Published var loginMode = false
    @Published var reg:Register? = nil
    @Published var user:UserData? = nil
    @Published var msg:String = ""
    
    func register(nickname:String,name:String,email:String,password:String,image:UIImage){
        DataUploader.uploadImage(path: "profile_image", nickName: nickname, image: image) { profileImageUrl in
            AuthApiService.register(nickname:nickname,email: email, name: name, password: password,profileImageUrl:profileImageUrl)
                .sink { completion in
                    print("히원가입 \(completion)")
                } receiveValue: { [weak self] receivedValue in
                    self?.reg = receivedValue
                    self?.registerSuccess.send(receivedValue.status)
                }.store(in: &self.cancellable)
        }
        
    }
    func login(email:String,password:String){
        AuthApiService.login(email: email, password: password)
            .sink { completion in
                print("로그인 \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.user = receivedValue.user
                self?.alret.send()
                self?.loginMode = receivedValue.status
                self?.msg = receivedValue.msg
            }.store(in: &cancellable)
    }
    func fetchUser(){
        UserApiService.userInfo()
            .sink { completion in
                print("쿠키 로그인 \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.user = receivedValue
                self?.loginMode = true
            }.store(in: &cancellable)
    }
    func logOut(){
        user = nil
        if let cookies = HTTPCookieStorage.shared.cookies{
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
                UserDefaults.standard.removeObject(forKey: "cookies")
                
            }
        }
        //print("현재 쿠키 :\(String(describing:HTTPCookieStorage.shared.cookies!))")
    }
    func infoChange(nickname:String,email:String,name:String,image:UIImage?,imageUrl:String){
        if let image = image{
            DataUploader.uploadImage(path: "profile_image", nickName: nickname, image: image) { profileImageUrl in
                AuthApiService.infoChange(nickname: nickname, email: email, name: name, imageUrl: profileImageUrl)
                    .sink { completion in
                        print("정보변경 \(completion)")
                    } receiveValue: { [weak self] receivedValue in
                        self?.user = receivedValue
                        self?.profileChange.send()
                    }.store(in: &self.cancellable)
            }
        }else{
            AuthApiService.infoChange(nickname: nickname, email: email, name: name, imageUrl: imageUrl)
                .sink { completion in
                    print("정보변경 \(completion)")
                } receiveValue: { [weak self] receivedValue in
                    self?.user = receivedValue
                    self?.infoChanges.send()
                }.store(in: &self.cancellable)
        }
    }
}
