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
        let random:Float = Float.random(in: 0...10)
        var name:String = ""
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge,.sound,]){ success, error in
            if success{
                print("허용")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        if listName == ""{
            content.title = "unknown"
            name = "\(random)"
        }else{
            content.title = listName
            name = listName
        }
        content.subtitle = "예약 시간 \(listTime)"
        content.sound = UNNotificationSound.default
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval) , repeats: false)
        let request = UNNotificationRequest(identifier: name, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //print(request)

    }
    func caancelAlarm(timeName:String){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [timeName])
    }
    
}
