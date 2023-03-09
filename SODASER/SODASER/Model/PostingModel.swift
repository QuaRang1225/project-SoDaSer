//
//  PostingModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/22.
//

import Foundation

struct PostingModel:Identifiable,Codable{
    
    var id:String = UUID().uuidString
    var title:String
    var diary:String
    var image:[String]
    
    
}



