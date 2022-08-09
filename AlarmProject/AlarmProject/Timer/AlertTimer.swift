//
//  File.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/08/09.
//

import Foundation
import SwiftUI

class AlertTimer{
    
    func alretTimer(timeinterval:Int,timeName:String){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge,.sound,]){ success, error in
            if success{
                print("허용")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        content.title = "타이머가 종료되었습니다."
        content.subtitle = "설정한 시간 \(timeName)"
        content.sound = UNNotificationSound.default
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval) , repeats: false)
        let request = UNNotificationRequest(identifier: timeName, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request){ (err) in
            if err != nil{
                print("에러")
            }
        }

    }
    
    func caancelAlarm(){

        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
    }
}
