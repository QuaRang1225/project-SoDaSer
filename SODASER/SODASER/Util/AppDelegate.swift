


import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth


class AppDelegate: NSObject, UIApplicationDelegate{
    
    let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String, loggingEnable:false)
        print("카카오앱키 : \(kakaoAppKey)")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           if (AuthApi.isKakaoTalkLoginUrl(url)) {
               return AuthController.handleOpenUrl(url: url, options: options)
           }
           return false
       }

}
