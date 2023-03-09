//
//  UserResponse.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/30.
//

import Foundation

struct UserResponse:Codable{
    var msg:String
    var status:Bool
    let user:UserData?
}
