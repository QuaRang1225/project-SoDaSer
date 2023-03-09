//
//  NotificationManager.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/23.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager{
    
    static let instance = NotificationManager()
    
    func requestAuth(){
        let options:UNAuthorizationOptions = [.alert,.sound,.badge] // 알림 옵션 지정
        UNUserNotificationCenter.current().requestAuthorization(options:options) { (success, error) in
            if let error = error{
                print("\(String(describing: error))")
            }else{
                print("알림 설정 성공")
            }
        }
    }
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "푸시알림"
        content.subtitle = "Boring님이 팔로우 요청을 하였습니다."
        content.sound = .default
        content.badge = UIApplication.shared.applicationIconBadgeNumber as NSNumber
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        let reqest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(reqest)
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

