//
//  TimeList.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/21.
//

import SwiftUI

class TimeList:Identifiable,ObservableObject{
    @Published var content : String
    init(content:String){
        self.content = content
    }
}
class ContentList:Identifiable,ObservableObject{
    @Published var content : String
    init(content:String){
        self.content = content
    }
}
