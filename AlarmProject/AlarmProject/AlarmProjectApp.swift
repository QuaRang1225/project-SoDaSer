//
//  AlarmProjectApp.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import SwiftUI

@main

struct AlarmProjectApp: App {
    //@StateObject private var store = TimeListStore()
    //let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()//.environment(\.managedObjectContext, store.container.viewContext)
            //Alarm().environmentObject(store)
        }
        
    }
}
