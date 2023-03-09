//
//  SODASERApp.swift
//  SODASER
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI
import Firebase

@main
struct SODASERApp: App {
    
    @StateObject var vm = AuthenticationViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            } .environmentObject(vm).onAppear{
                NotificationManager.instance.requestAuth()
            }
        }
    }
}
