//
//  FavoriteViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import Foundation
import Alamofire
import Combine

class FavoriteViewModel:ObservableObject{
    
    var favoritSaveSuccess = PassthroughSubject<(),Never>()
    var favortieListLoad = PassthroughSubject<(),Never>()
    var cancellable = Set<AnyCancellable>()
    @Published var favoriteResponse:FavoriteResponse?
    @Published var favoritList = [Favorite]()
    
    func favorite(keyWord:String,city:String,location:String,lat:Double,long:Double,title:String,image:String){
        UserApiService.favorite(keyWord: keyWord, city: city, location: location, lat: lat, long: long,title:title,image:image)
            .sink { completion in
                print("즐겨찾기 저장")
            } receiveValue: { [weak self] receivedValue in
                self?.favoriteResponse = receivedValue
                self?.favoritSaveSuccess.send()
            }.store(in: &cancellable)
    }
    func favoriteResponse(keyWord:String){
        UserApiService.favoriteResponse(keyWord: keyWord)
            .sink { completion in
                print("즐겨찾기 저장")
            } receiveValue: { [weak self] receivedValue in
                self?.favoritList = receivedValue
            }.store(in: &cancellable)

    }
}
