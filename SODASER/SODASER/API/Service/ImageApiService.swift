//
//  ImageApiService.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/04.
//

import Foundation
import UIKit
import Alamofire

enum ImageApiService{
    static func imageUpload(imageData: [UIImage?],title:String){
        let interceptor = BaseIntercept()
        
        let URL = ApiClient.SODASER_SERVER_URL      //URL 지장
        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data"]        //multiform 형식으로
        let parameters: [String : Any] = ["fileName":title]         //사진 이름 설정
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)     //사진 정보
            }
            for images in imageData{
                if let image = images?.jpegData(compressionQuality: 1.0) {
                    multipartFormData.append(image, withName: "fileImage", fileName: "\(image).jpeg", mimeType: "image/jpeg")   //사진데이터
                }
            }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header,interceptor: interceptor).response { response in
            guard let statusCode = response.response?.statusCode,
                  statusCode == 200
            else { return }
            print("이미지 업로드 성공")
           
        }
    }
}
