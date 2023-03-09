//
//  ProfileSelectView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/02.
//


import SwiftUI
import PhotosUI
import MapKit

struct ProfileSelectView: View {
    
    //let reg:Register
    
    @Binding var nickname:String
    @Binding var email:String
    @Binding var name:String
    @Binding var password:String
    
    @State var isProgress = false
    @State var showisRegister = false
    @Binding var moveView:Bool
    @StateObject var photo = PhotoPicker()
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            mainView
            .alert("\(String(describing: vmAuth.reg?.name ?? ""))님의 회원가입이 완료되었습니다.",isPresented: $showisRegister){
                Button("확인",role: .cancel){
                    moveView = false
                }
            }
            .onReceive(vmAuth.registerSuccess, perform: { value in
                showisRegister = value
            })
            .ignoresSafeArea()
            .navigationBarHidden(true)
            if isProgress{
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView().tint(.white)
            }
        }
    }
    private struct imageModifier:ViewModifier{
        func body(content: Content) -> some View {
            content
                .frame(width: 250,height: 250)
                .padding()
        }
    }
}


struct ProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileSelectView(nickname: .constant(""),email: .constant(""),name: .constant(""),password: .constant(""),moveView: .constant(true)).environmentObject(AuthenticationViewModel())
           
        }
    }
}

extension ProfileSelectView{
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
                
                VStack(spacing: 20){
                    Image("photo")
                        .resizable()
                        .frame(width: 200,height: 50)
                        
                        .shadow(radius: 20)
                        .padding(.top,70)
                        .padding(.bottom,30)
                    PhotosPicker(selection: $photo.selectItem, maxSelectionCount: 1, matching: .images){
                        if photo.selectPhotoItem.isEmpty{
                            ZStack{
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .modifier(imageModifier())
                                Circle()
                                    .stroke(Color.white,lineWidth: 5)
                                    .modifier(imageModifier())
                            }
                        }
                        else{
                            ForEach(photo.selectPhotoItem,id: \.self){
                                if let image = UIImage(data: $0){
                                    VStack{
                                        Image(uiImage: image)
                                            .resizable()
                                            .clipShape(Circle())
                                            .scaledToFill()
                                            .modifier(imageModifier())
                                            .padding(.bottom)
                                        Button {
                                            vmAuth.register(nickname: nickname, name: name, email: email, password: password, image: image)
                                            isProgress = true
                                        } label: {
                                            Text("완료")
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
                                        .shadow(radius: 10)
                                    }
                                }
                            }
                        }
                    }.onChange(of: photo.selectItem,perform: photo.selectPhoto)
                    Spacer()
                    
                }
            }
            
        }
        .background {
            Color.white.ignoresSafeArea()
        }
    }
}
