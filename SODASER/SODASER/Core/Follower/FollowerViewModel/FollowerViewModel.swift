//
//  FollowerViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/02.
//

import Foundation
import Combine

class FollowerViewModel:ObservableObject{
    
    @Published var followerList:[UserData] = []
    @Published var followingList:[UserData] = []
    @Published var users:[UserData] = []
    @Published var follow:Follow? = nil
    @Published var myfollow:[UserData] = []
    @Published var user:UserData? = nil
    
    var cancaellable = Set<AnyCancellable>()
    var followSuccess = PassthroughSubject<Bool,Never>()
    
    func following(targetUser:String){
        FollowApiService.follow(targetUser: targetUser)
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.follow = receivedValue
                self?.followSuccess.send(true)
            }.store(in: &cancaellable)
    }
    
    func getFollowerList(email:String){
        FollowApiService.followerList(email: email)
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.followerList = receivedValue
            }.store(in: &cancaellable)
    }
    func getFollowingList(email:String){
        FollowApiService.followingList(email: email)
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.followingList = receivedValue
            }.store(in: &cancaellable)
    }
    func otherUser(email:String){
        UserApiService.otherUser(email: email)
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.user = receivedValue
            }.store(in: &cancaellable)
    }
    func usersInfo(){
        UserApiService.usersInfo()
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: {  [weak self] receivedValue in
                self?.users = receivedValue
            }.store(in: &cancaellable)

    }
    func getMyFollowingList(email:String){
        FollowApiService.followingList(email: email)
            .sink { completion in
                print("completion - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.myfollow = receivedValue
            }.store(in: &cancaellable)
    }
}
