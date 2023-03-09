//
//  RegisterView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/02.
//

import SwiftUI
import MapKit

struct RegisterView: View {
    
    @State var isActive = false //프로필 사진 선택
    
    @State var passwordStatus = false   //비밀번호 확인
    @State var statusMessage = ""
    @State var nickname:String = ""
    @State var email:String = ""
    @State var name:String = ""
    @State var password:String = ""
    @State var passwordConfirm:String = ""
    @Binding var moveView:Bool
    
    
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        mainView
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(moveView: .constant(true)).environmentObject(AuthenticationViewModel())
    }
}

extension RegisterView{
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
                Group{
                    Color.whiteCyan.ignoresSafeArea()
                }
                .clipShape(RoundedShape(corners: [.topLeft], width: 100, height: 20)).ignoresSafeArea()
                
                VStack(alignment: .leading,spacing: 20){
                    Image("register")
                        .resizable()
                        .frame(width: 170,height: 50)
                        .shadow(radius: 20)
                        .padding(.top,70)
                        .padding(.leading,30)
                        .padding(.bottom,30)
                    Group{
                        VStack(alignment: .leading){
                            Text("닉네임").bold()
                            CustomInputView(imageName: "person.fill", placeholderText: "입력 ..",imageColor: .blackIndigo, text: $nickname)
                        }
                        VStack(alignment: .leading){
                            Text("이름").bold()
                            CustomInputView(imageName: "person", placeholderText: "입력 ..", imageColor: .blackIndigo, text: $name)
                        }
                        VStack(alignment: .leading){
                            Text("이메일").bold()
                            CustomInputView(imageName: "envelope.fill", placeholderText: "입력 ..", imageColor: .blackIndigo, text: $email).keyboardType(.emailAddress)
                        }
                        VStack(alignment: .leading){
                            Text("비밀번호").bold()
                            CustomInputView(imageName: "lock", placeholderText: "입력 ..",securefield: true, imageColor: .blackIndigo, text: $password)
                        }
                        VStack(alignment: .leading){
                            Text("비밀번호 확인").bold()
                            CustomInputView(imageName: "lock.fill", placeholderText: "입력 ..",securefield: true, imageColor: .blackIndigo, text: $passwordConfirm)
                        }
                        VStack{
                            register.padding()
                            loginTransferButton
                                .frame(maxWidth: .infinity,alignment: .center)
                        }
                        
                    }.padding(5)
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
            .navigationDestination(isPresented:$isActive){
                ProfileSelectView(nickname: $nickname, email: $email, name: $name, password: $password, moveView: $moveView)
            }
    }
    var register:some View{
        Button {
            if nickname.isEmpty || password.isEmpty || passwordConfirm.isEmpty || name.isEmpty || email.isEmpty{
                self.passwordStatus = true
                self.statusMessage = "정보를 정확하게 입력해주세요!!"
                
            }else if password != passwordConfirm && !password.isEmpty && !passwordConfirm.isEmpty{
                self.passwordStatus = true
                self.statusMessage = "비밀번호가 일치하지 않습니다!!"
                print(statusMessage)
            }else{
                isActive = true
            }
        } label: {
            Text("회원가입")
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
        .alert(isPresented: $passwordStatus){
            Alert(title: Text(statusMessage),dismissButton: .default(Text("확인")))
        }
        
        
    }
    var loginTransferButton:some View{
        Button {
            moveView = false
        } label: {
            HStack{
                Text("계정이 이미 있으신가요?")
                    .font(.footnote)
                Text("로그인")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            
        }
        .padding(.bottom,30)
        .foregroundColor(.blackIndigo)
    }
    
    
}
