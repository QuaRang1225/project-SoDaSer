//
//  Favorite.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import Foundation

struct Favorite:Codable,Identifiable{
    var id = UUID()
    var keyWord:String
    var city:String
    var location:String
    var lat:Double
    var long:Double
    var title:String
    var image:String
}
