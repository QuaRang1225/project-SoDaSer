//
//  PostViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/10.
//

import Foundation
import Combine
import MapKit
import Kingfisher

class PostViewModel:ObservableObject{
    
    
    var cancellable = Set<AnyCancellable>()
    var postSuccess = PassthroughSubject<Bool,Never>()
    var listViewSuccess = PassthroughSubject<(),Never>()
    //var listRowViewSuccess = PassthroughSubject<(),Never>()
    //var arr = [String]()
    
    let imageFolderName = "ImageFolder"
    let profileFolderName = "ProfileFolder"
    
    @Published var category = ""
    @Published var locationName = ""
    @Published var cityName = ""
    
    @Published var response:PostResponse? = nil
    @Published var post:[Post] = []
    @Published var reply:Reply? = nil
    @Published var feed:[Feed] = []
    //@Published var userInfo:UserData? = nil
    
    func categorySend(menu:String){
        self.category = menu
        print("카테고리 : \(category) 주소지 : \(locationName) 지역 : \(cityName)")
    }
    func locationSet(locationName:String,cityName:String){
        self.locationName = locationName
        self.cityName = cityName
    }
    
    func posting(nickName:String,title:String,catergoryValue:String,diary:String,image:UIImage,long:Double,lat:Double){
        DataUploader.uploadImage(path: "postingImage", nickName: nickName, image: image) { imageUrl in
            UserApiService.posting(title: title, catergoryValue: catergoryValue, diary: diary, long: long, lat: lat,image: imageUrl)
                .sink { completion in
                    print("포스팅완료 \(completion)")
                } receiveValue: {  [weak self] receivedValue in
                    self?.response = receivedValue
                    self?.postSuccess.send(receivedValue.status)
                }.store(in: &self.cancellable)
        }
    }
    func postList(email:String){
        UserApiService.postList(email: email)
            .sink {  (completion) in
                print("포스팅리스트 \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.post = receivedValue
            }.store(in: &cancellable)

    }
    func downloadImage(imageUrl:String,id:String,location:String,profileUrl:String){
        guard
            let url = URL.init(string: imageUrl),
            let proUrl = URL.init(string: profileUrl)
        else {return}
        let resource = ImageResource(downloadURL: url)
        let proResource = ImageResource(downloadURL: proUrl)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                LocalFileManager.instance.save(image: value.image, imageName: id, folderName: self.imageFolderName)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        KingfisherManager.shared.retrieveImage(with: proResource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                LocalFileManager.instance.save(image: value.image, imageName: id, folderName: self.profileFolderName)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        LocalFileManager.instance.saveFile(stringData: location, fileName: id + location)
    }
    func reply(text:String,endPoint:String){
        PostApiService.reply(text: text, endPoint: endPoint)
            .sink { completion in
                print("댓글 - \(completion)")
            } receiveValue: { [weak self] recieveValue in
                self?.reply = recieveValue
            }.store(in: &cancellable)
    }
    func feedList(){
        PostApiService.feed()
            .sink { completion in
                print("피드 - \(completion)")
            } receiveValue: { [weak self] receivedValue in
                self?.feed = receivedValue
                self?.listViewSuccess.send()
            }.store(in: &cancellable)
    }
//    func user(email:String){
//        UserApiService.otherUser(email: email)
//            .sink { completion in
//                print("유저 정보 - \(completion)")
//            } receiveValue: { receivedValue in
//                self.userInfo = receivedValue
//                self.listRowViewSuccess.send()
//            }.store(in: &cancellable)
//
//    }
}
