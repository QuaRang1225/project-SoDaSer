//
//  PhotoPicker.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/02.
//


import Foundation
import SwiftUI
import PhotosUI
import Combine

class PhotoPicker:ObservableObject{
    
    let itemKey:String = "게시물"
    
    
    @Published var selectItem:[PhotosPickerItem] = []
    @Published var selectPhotoItem:[Data] = []
    
    
    func selectPhoto(item:[PhotosPickerItem]){
        selectPhotoItem.removeAll() //사진을 새로 선택할 때마다 상태변경
        Task {  //사진 저장 동기처러
            for newItem in item {
                //Task - 비동기
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    selectPhotoItem.append(data)
                    
                }
            }
            
        }
    }
    func deletePhoto(){
        selectItem.removeAll()
        selectPhotoItem.removeAll()
    }

    
    
}
