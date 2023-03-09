//
//  ImageUploader.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/06.
//

import Foundation
import SwiftUI
import FirebaseStorage
import Combine
import Alamofire

struct DataUploader{
    
    static func uploadImage(path:String,nickName:String,image:UIImage,completion: @escaping (String) -> Void){    //이미지를 업로드하는 '클로저'를 실행해야함으로 @escaping 어노테이션 추가
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else{ return }       //compressionQuality 압축품질 0(낮은품질) ~ 1(높은 품질)
        let filename = NSUUID().uuidString  //앱 실행마다 다른 값을 사용하기 위함
        let ref = Storage.storage().reference(withPath: "/\(nickName)/\(path)/\(filename)")   //프로필 이미지를 저장할 포맷 지정
        
        ref.putData(imageData,metadata:nil){ _, error in   //데이터 저장
            if let error = error{
                print("DEBUG: 이미지 업로드가 실패했습니다. \(error.localizedDescription)")
                return
            }
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else{ return }    //absoluteString - 절대 주소값 : urlString과 동일
                return completion(imageUrl)
            }
        }
    }
//    static func uploadLocation(dateFormatter:String,path:String,nickName:String,completion:@escaping (String) -> Void){
//
//
//        let ref = Storage.storage().reference(withPath: "/\(nickName)/\(path)/\(dateFormatter)")   //본인 위치를 저장할 포맷 지정
//
//        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{return}
//        let filepath = url.appendingPathComponent(dateFormatter + ".txt")
//
//        do {
//            let dataFromPath: Data = try Data(contentsOf: filepath) // URL을 불러와서 Data타입으로 초기화
//            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
//
//            ref.putData(dataFromPath,metadata:nil){ _, error in   //데이터 저장
//                if let error = error{
//                    print("DEBUG: 로그리스트 업로드가 실패했습니다. \(error.localizedDescription)")
//                    return
//                }
//                ref.downloadURL { locationUrl, _ in
//                    guard let locationUrl = locationUrl?.absoluteString else{ return }    //absoluteString - 절대 주소값 : urlString과 동일
//                    return completion(locationUrl)
//                }
//            }
//            print(text) // 출력
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//
//    }
    
    
}
