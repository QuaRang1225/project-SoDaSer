//
//  InfoChangeView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/25.
//

import SwiftUI

struct InfoChangeView: View {
    

    let passwordChange:Bool
    let user:UserData
    @State var infoFilter:InfoFilter
    @State var text:String
    @State var passwordConfirm:String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    var body: some View {
        VStack{
            ZStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .shadow(color: .black, radius: 20)
                }.frame(maxWidth: .infinity,alignment: .leading)
                Text(infoFilter.title + " 변경").bold().frame(maxWidth: .infinity,alignment: .center)
                Button {
                    switch infoFilter{
                    case .name:
                        vmAuth.infoChange(nickname: user.nickname, email: user.email, name: text, image: nil, imageUrl: user.profileImage ?? "")
                    case .nickname:
                        vmAuth.infoChange(nickname: text, email: user.email, name: user.name, image: nil, imageUrl: user.profileImage ?? "")
                    }
                    dismiss()
                } label: {
                    Text("변경")
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
            }.padding(.bottom,50)
            if passwordChange{
                HStack{
                    Text(infoFilter.title).bold()
                        .padding(.trailing,5)
                        .padding(.bottom,7.5)
                    SecureField("", text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                        .overlay(alignment:.leading){
                            Text(text != "" ? "" : "입력 ..").opacity(0.5)
                        }
                        .padding(.bottom,7.5)
                        .overlay(alignment:.trailing){
                            xmark.offset(x:20).padding(.bottom,5)
                        }
                }
                Divider()
                HStack{
                    Text(infoFilter.title + " 확인").bold()
                        .padding(.trailing,5)
                        .padding(.bottom,7.5)
                    SecureField("", text: $passwordConfirm)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                        .overlay(alignment:.leading){
                            Text(text != "" ? "" : "입력 ..").opacity(0.5)
                        }
                        .padding(.bottom,7.5)
                        .overlay(alignment:.trailing){
                            xmarkConfirm.offset(x:20).padding(.bottom,5)
                        }
                }
                Divider()
                Spacer()
            }
            else{
                HStack{
                    Text(infoFilter.title).bold()
                        .padding(.trailing,5)
                        .padding(.bottom,7.5)
                    TextField("", text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                        .overlay(alignment:.leading){
                            Text(text != "" ? "" : "입력 ..").opacity(0.5)
                        }
                        .padding(.bottom,7.5)
                        .overlay(alignment:.trailing){
                            xmark.offset(x:20).padding(.bottom,5)
                        }
                }
                Divider()
                Spacer()
            }
            
            
        }
        .padding()
        .foregroundColor(.blackIndigo)
        .navigationBarHidden(true)
        .background(Color.white.ignoresSafeArea())
        
    }
}

struct InfoChangeView_Previews: PreviewProvider {
    static var previews: some View {
        InfoChangeView(passwordChange: false, user: CustomPreView.instance.user, infoFilter: .name, text: "hero1225")
            .environmentObject(AuthenticationViewModel())
    }
}
extension InfoChangeView{
    var xmark:some View{
        Image(systemName: "xmark.circle.fill")
            .font(.headline)
            .padding(30)
            .opacity(text.isEmpty ?  0.0 : 1.0)
            .onTapGesture {
                UIApplication.shared.endEditing()
                text = ""
                print("눌림")
            }
    }
    var xmarkConfirm:some View{
        Image(systemName: "xmark.circle.fill")
            .font(.headline)
            .padding(30)
            .opacity(passwordConfirm.isEmpty ?  0.0 : 1.0)
            .onTapGesture {
                UIApplication.shared.endEditing()
                passwordConfirm = ""
                print("눌림")
            }
    }
}
