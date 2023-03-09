//
//  MenuView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/20.
//

import SwiftUI
import Kingfisher
import PhotosUI

struct MenuView: View {
    
    let user:UserData?
    @State var isButton = false
    @State var profileChange = false
    @State var deleteAccount:Bool = false
    @State var progrseeView = false
    @State var logOutMode = false
    @Binding var logOut:Bool
    @Environment(\.dismiss) var dismiss
    @StateObject var post = PhotoPicker()
    @EnvironmentObject var vm:AuthenticationViewModel
    
    var body: some View {
        ZStack{
            Color.whiteCyan2.ignoresSafeArea()
                
            if let user = user{
                mainView(profile:profileImage(user: user), user: user)
                
            }
            if progrseeView{
                Color.black.opacity(0.5).ignoresSafeArea()
                VStack{
                    Text("로그아웃 중..").foregroundColor(.white).bold()
                    ProgressView()
                }
            }
            if profileChange{
                Color.black.opacity(0.5).ignoresSafeArea()
                VStack{
                    Text("프로필사진 변경 중..").foregroundColor(.white).bold()
                    ProgressView()
                }
            }
        } .onChange(of: post.selectItem,perform: post.selectPhoto)
            .onReceive(vm.profileChange) {
                profileChange = false
            }
    }
}

struct MenuView_Previews: PreviewProvider{
    
    static var previews: some View {
        MenuView(user: CustomPreView.instance.user, logOut: .constant(false)).environmentObject(AuthenticationViewModel())
    }
}


extension MenuView{
    func profileImage(user:UserData) ->some View{
            PhotosPicker(selection: $post.selectItem, maxSelectionCount: 1, matching: .images){
                ZStack{
                    if post.selectPhotoItem.isEmpty{
                        if let profileImage = user.profileImage{
                            KFImage(URL(string:profileImage)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75,height: 75)
                                .clipShape(Circle())
                        }else{
                            DummyCircle(width: 75, height: 75)
                        }
                            
                    }else{
                        if let data = post.selectPhotoItem.first{
                            if let image = UIImage(data: data){
                                if !profileChange{
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 75,height: 75)
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    Circle().foregroundColor(.black.opacity(0.3)).frame(width: 75,height: 75)
                    VStack(spacing:5){
                        Text("변경").bold()
                        Image(systemName: "repeat")
                    }
                }.padding(.trailing,20).foregroundColor(.white)
            }
        
        
       
        .padding(.trailing,20)
            
            
        
        
    }
    func mainView(profile:some View,user:UserData) -> some View{
        VStack(alignment: .leading,spacing: 30){
                header
            profileView(profile: profile, user: user)
            
            
                
            Group{
                NavigationLink {
                    InfoChangeView(passwordChange: false, user: user, infoFilter: InfoFilter.name, text: user.name)
                } label: {
                    Text("이름 변경")
                }
                NavigationLink {
                    InfoChangeView(passwordChange: false, user: user, infoFilter: InfoFilter.nickname, text: user.nickname)
                } label: {
                    Text("닉네임 변경")
                }
//                NavigationLink {
//                    InfoChangeView(changeText: "이메일", passwordChange: false, user: user, text: email).keyboardType(.emailAddress)
//                } label: {
//                    Text("이메일 변경")
//                }
//                NavigationLink {
//                    InfoChangeView(changeText: "비밀번호", passwordChange: true, user: user, text: "hero1225")
//                } label: {
//                    Text("비밀번호 변경")
//                }
                deleteAccountButton
                
            }
            .bold()
            .font(.callout)
            .padding()
            
            
            Spacer()
            HStack{
                logoutButton
                Spacer()
            }.padding()
            
        }.padding()
            .foregroundColor(.blackIndigo)
            .navigationBarHidden(true)
        
        
    }
    var header:some View{
        ZStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .bold()
                    .shadow(color: .black, radius: 20)
            }.frame(maxWidth: .infinity,alignment: .leading)
            Text("프로필 변경").bold().frame(maxWidth: .infinity,alignment: .center)
        }
    }
    var deleteAccountButton:some View{
        Button(action: {
            deleteAccount.toggle()
        }){
            Text("계정 삭제하기").foregroundColor(.red)
        }.alert(isPresented : $deleteAccount){
            Alert(title: Text("계정을 삭제 하시겠습니까?"),message: Text("계정을 삭제하면 복구 할수 없습니다"), primaryButton: .destructive(Text("삭제"),action: {
                print("")
            }), secondaryButton: .cancel(Text("취소")))
        }
    }
    var logoutButton:some View{
        Button(action: {
            logOutMode.toggle()
        }){
            Image(systemName: "door.left.hand.open")
                .font(.system(size: 20))
                .foregroundColor(.black)
        }.onAppear{
            print(logOut)
        }
        .alert(isPresented : $logOutMode){
            Alert(title: Text("로그아웃을 하시겠습니까?"),message: Text("로그아웃을 할 경우 로그인 화면으로 바로 넘어가게 됩니다."), primaryButton: .destructive(Text("로그아웃"),action: {
                vm.logOut()
                logOut = false
            }), secondaryButton: .cancel(Text("취소")))
        }
    }
    func profileView(profile:some View,user:UserData) -> some View{
        VStack(alignment: .leading ,spacing:0){
            HStack(spacing:0){
                profile
                VStack(alignment: .leading,spacing: 10){
                    if let user = vm.user{
                        Text(user.nickname)
                            .font(.title2)
                            .bold()
                        Text(user.name)
                            .font(.title3)
                    }
                }
                Spacer()
                if !post.selectItem.isEmpty{
                    if let data = post.selectPhotoItem.first{
                        if let image = UIImage(data: data){
                            Button {
                                profileChange = true
                                vm.infoChange(nickname: user.nickname, email: user.email, name: user.name, image: image, imageUrl: user.profileImage ?? "")
                            } label: {
                                Text("확인")
                                    .padding(.horizontal)
                                    .padding(5)
                                    .background(Color.blackIndigo)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    //.opacity(profileChange ? 0.0:1.0)
                            }
                        }
                    }
                }
            }
            
        }.padding()
    }
}
