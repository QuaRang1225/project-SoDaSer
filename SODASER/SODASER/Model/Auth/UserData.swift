//
//  UserDataModel.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/22.
//

import Foundation



struct UserData:Codable,Hashable{
    
    var email:String
    var name:String
    var nickname:String
    var profileImage:String?
    
}
  
