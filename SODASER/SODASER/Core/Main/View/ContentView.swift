//
//  ContentView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/12/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth


struct ContentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var logoAnimation = false
    @State var showisLogin = false
    
    
    @StateObject var vmPost = PostViewModel()
    @StateObject var vmAuth = AuthenticationViewModel()
    @StateObject var vmFollow = FollowerViewModel()
    
    var body: some View {
        
        ZStack{
            if logoAnimation{
                if vmAuth.loginMode{
                    if let user = vmAuth.user{
                        MainView(user: user)
                            .environmentObject(vmFollow)
                            .environmentObject(vmAuth)
                            .environmentObject(vmPost)
                    }
                }else{
                    LoginView()
                        .environmentObject(vmAuth)
                }
            }else{
                StartView()
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut(duration: 1.0)){
                    logoAnimation = true
                }
            }
            UserDefaultManager.shared.restore()
            vmAuth.fetchUser()
            //vmAuth.login(email: "dbduddnd1225@gmail.com", password: "hero1225")
            
            //    print("현재 쿠키 :\(String(describing:HTTPCookieStorage.shared.cookies!))")
        }
        .onReceive(vmAuth.alret){
            self.showisLogin = true
        }.alert(vmAuth.msg ,isPresented: $showisLogin){
            Button("확인",role: .cancel){
                self.dismiss()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
        .navigationBarHidden(true)
    }
}
