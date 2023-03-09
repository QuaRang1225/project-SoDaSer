//
//  PostModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/09.
//

import Foundation

struct PostModel:Codable{
    
    var id:Int
    var title:String            //제목
    var category:String   //카테고리
    var contents:String            //일기
    var image:String         //이미지 url
    var longitude:Decimal             //위도
    var latitude:Decimal              //경도
}
