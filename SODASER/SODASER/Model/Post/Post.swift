//
//  Posting.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/04.
//


import Foundation
import CoreLocation

struct Post:Codable,Identifiable,Hashable{
    
    var id:Int
    var user:String
    var title:String            //제목
    var category:String?   //카테고리
    var contents:String            //일기
    var image:String         //이미지 url
    var longitude:Decimal             //위도
    var latitude:Decimal              //경도
    var createTime:String
    
    var coordinate:CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: NSDecimalNumber(decimal:latitude).doubleValue ,longitude: NSDecimalNumber(decimal:longitude).doubleValue)
    }


}
