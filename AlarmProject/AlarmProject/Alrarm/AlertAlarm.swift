//
//  AlertAlarm.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI

class AlertAlarm{
    func alertalram(timeinterval:Int,listName:String,listTime:String){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge,.sound,]){ success, error in
            if success{
                print("허용")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        content.title = listName
        content.subtitle = "예약 시간 \(listTime)"
        content.sound = UNNotificationSound.default
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval) , repeats: false)
        let request = UNNotificationRequest(identifier: listName, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //print("ddd")
    }
    
}
