//
//  StopWatchStore.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/08/01.
//

import Foundation
import SwiftUI

class StopWatchStore{
    func timeStore(mac:Any){
        let time = Entity(context:mac)
        time.stopwatchList = String(format: "%00.1f", stopWatchClass.timeElapsed)
        try? mac.save()
    }
}
