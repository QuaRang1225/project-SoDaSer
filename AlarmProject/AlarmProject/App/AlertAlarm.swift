//
//  AlertAlarm.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI

class AlertAlarm{
    
    static var name:String = ""
    static var num  = 0
    
    func alertalram(timeinterval:Int,listName:String,listTime:String,repeatAlret:Bool){
        
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
        }else{
            content.title = listName
        }
        content.subtitle = "예약 시간 \(listTime)"
        content.sound = UNNotificationSound.default
        let sentence = listName + listTime
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval)-1, repeats: false)
        let request = UNNotificationRequest(identifier: sentence, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request){ (err) in
            if err != nil{
                print("에러")
            }
        }
        
        

        
        print(sentence)
        

        

    }
    func caancelAlarm(name:String,num: String){

        let center = UNUserNotificationCenter.current()
        let sentence = name + num
        center.removeDeliveredNotifications(withIdentifiers: [sentence,sentence + "1"])
        center.removePendingNotificationRequests(withIdentifiers: [sentence,sentence + "1"])
        print(sentence)
        
    }
    
}
