//
//  LoginView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/22.
//



import SwiftUI
import MapKit
import CoreLocationUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

struct LoginView: View {
    
    
    @State var email:String = ""
    @State var password:String = ""
    
    @State var moveView = false     //최상위 뷰설정
    
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            mainView
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationViewModel())
            .environmentObject(MainViewModel())
        
    }
}

extension LoginView{
    var mainView:some View{
        VStack{
            Spacer().frame(height: 200)
            ZStack(alignment: .top){
                MapView(isView: false, mod: false)
                    .frame(width: 250,height: 250)
                    .clipShape(Circle())
                    .offset(y:-120)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .offset(x:-50)
                    .shadow(radius: 20)
                Color.whiteCyan.ignoresSafeArea()
                .clipShape(RoundedShape(corners: [.topLeft], width: 100, height: 20)).ignoresSafeArea()
                
                VStack(alignment: .leading,spacing: 20){
                    Image("login")
                        .resizable()
                        .frame(width: 120,height: 50)
                        .shadow(radius: 20)
                        .padding(.top,70)
                        .padding(.leading,40)
                        .padding(.bottom,30)
                    Group{
                        VStack(alignment: .leading){
                            Text("이메일").padding(.bottom).bold()
                            CustomInputView(imageName: "person", placeholderText: "이메일", imageColor: .blackIndigo, text: $email).keyboardType(.emailAddress)
                        }
                        VStack(alignment: .leading){
                            Text("비밀번호").padding(.bottom).bold()
                            CustomInputView(imageName: "lock", placeholderText: "비밀번호",securefield: true, imageColor: .blackIndigo, text: $password)
                        }
                        VStack{
                            login.padding()
                            regisetTransferButton
                                .frame(maxWidth: .infinity,alignment: .center)
                        }
                        
                    }.padding(20)
                        .padding(.horizontal,30)
                        .foregroundColor(.blackIndigo)
                    
                    Spacer()
                    
                }
            }
            
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .background {
            Color.white.ignoresSafeArea()
        }
        
    }
    var login:some View{
        Button {
            vmAuth.login(email: email, password: password)
        } label: {
            Text("로그인")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(width: 300,height: 50)
                .background(LinearGradient(
                    colors: [.blackIndigo, .black],
                    startPoint: .leading,
                    endPoint: .trailing))
                .clipShape(Capsule())
                .padding(.horizontal)
            
        }
    }
    var regisetTransferButton:some View{
        Button {
            moveView = true
        } label: {
            HStack{
                Text("계정이 없으신가요?")
                    .font(.footnote)
                Text("회원가입")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            //.padding(.bottom,30)
            .foregroundStyle(
                LinearGradient(
                colors: [.blackIndigo, .black],
                startPoint: .leading,
                endPoint: .trailing))
        }
        .navigationDestination(isPresented: $moveView) {
            RegisterView(moveView: $moveView).navigationBarHidden(true)
        }
    }
}
