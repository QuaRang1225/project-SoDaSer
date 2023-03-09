//
//  TabImageView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/21.
//

import SwiftUI
import MapKit
import PhotosUI

struct TabImageView: View {
    
    @State var ispostSuccess = false    //체크
    @Binding var isActive:Bool  //루트 뷰 이동
    @State var fullPhoto = false    //사진 탭뷰
    @State var deletePhoto = false  //사진 삭제 알림
    @State var text = ""    //제목 placeholder
    @State var diary:String = ""    //일기 텍스트
    @State var isProgress = false   //로딩뷰
    @State var image:UIImage? = nil
    @State var region = MKCoordinateRegion()
    @State var coordinate:CLLocationCoordinate2D
    @State var category:PostCatrgory = .unknown
    
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    @EnvironmentObject var vmMap:MapViewModel
    @StateObject var post = PhotoPicker()
    @StateObject var vmPost = PostViewModel()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .top){
            Map(coordinateRegion:$region,showsUserLocation: false)
            //Color.whiteCyan
                .ignoresSafeArea()
            VStack(spacing: 30){
                header
                    .padding(.bottom,10)
                    .background {
                        Color.black.opacity(0.5).ignoresSafeArea()
                    }
                    Spacer()
                ZStack(alignment: .top){
                    VStack(spacing: 0){
                        Spacer().frame(height: 50)
                        HStack(alignment: .bottom,spacing: 0){
                                title.padding(.horizontal).padding(.top)
                                VStack(alignment: .leading){
                                    CustomInputView(imageName: nil, placeholderText: "제목 ..", imageColor: .blackIndigo, text: $text)
                                        .padding(.bottom,10)
                                        .padding(.trailing)
                                    Picker("",selection: $category){
                                        ForEach(PostCatrgory.allCases,id: \.self) { item in
                                            Text(item.title)
                                                .onAppear{
                                                    category = item
                                                }
                                        }
                                    }.pickerStyle(.menu)
                                        .padding(.horizontal)
                                        .background(.black.opacity(0.2)).cornerRadius(10)
                                        .accentColor(.white)
                                }
                        }
                        diaryText()
                    }.background {
                        Color.white
                            .clipShape(RoundedShape(corners: [.bottomRight,.topRight], width: 20, height: 20))
                            .shadow(radius: 10)
                            .padding(.trailing)
                            .padding(.top,50)
                            
                            
                    }
                    Image("pencil")
                        .resizable()
                        .frame(width: 180,height: 100)
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        .ignoresSafeArea()
                        .padding(.trailing,200)
                }
            }
            if fullPhoto, !post.selectPhotoItem.isEmpty{
                photoTap
            }
            if isProgress{
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView().tint(.white).frame(maxHeight: .infinity,alignment: .center)
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }.onAppear{
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        }
        
        .navigationBarHidden(true)
        
    }
}

struct TabImageView_Previews: PreviewProvider {
    static var previews: some View {
        TabImageView(isActive: .constant(true), coordinate: CLLocationCoordinate2D())
            .environmentObject(AuthenticationViewModel())
            .environmentObject(MapViewModel())
    }
}

extension TabImageView{
    private var photoTap:some View{
        ZStack{
            Color.black.opacity(0.8).ignoresSafeArea().onTapGesture {
                fullPhoto = false
            }
            VStack{
                TabView{
                    ForEach(post.selectPhotoItem,id: \.self){ index in
                        if let image = UIImage(data:index){
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        }
                    }
                }
                .frame(width: UIScreen.photoWidth,height: UIScreen.photoWidth)
                .shadow(radius: 10)
                .tabViewStyle(PageTabViewStyle())
                HStack{
                    plusButtonView(Text("사진 재설정"))
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 150,height: 50)
                        .padding()
                    backButton
                }
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        }
    }
    private var title:some View{
        HStack(alignment: .bottom){
            if post.selectPhotoItem.isEmpty{
                RoundedRectangle(cornerRadius: 20).foregroundColor(.black.opacity(0.2))
                    .frame(width: 150,height: 150)
                    .overlay {
                        plusButtonView(Image(systemName: "photo")).font(.system(size: 50)).foregroundColor(.white)
                    }
            }
            else{
                ZStack{
                    Button {
                        fullPhoto = true
                    } label: {
                        if let data = post.selectPhotoItem.first{
                            if let image = UIImage(data: data){
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150,height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                }
            }
        }
    }
    private func plusButtonView(_ buttonType:some View)->some View{
        PhotosPicker(selection: $post.selectItem, maxSelectionCount: 1, matching: .images){
            buttonType
        }
        .onChange(of: post.selectItem,perform: post.selectPhoto)
    }
    private var backButton:some View{
        Text("사진 전체 삭제")
            .font(.headline)
            .bold()
            .foregroundColor(.white)
            .onTapGesture {
                deletePhoto.toggle()
            }.alert(isPresented : $deletePhoto){
                Alert(title: Text("사진을 모두 삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제"),action: {
                    fullPhoto = false
                    post.deletePhoto()
                }), secondaryButton: .cancel(Text("취소")))
            }.padding()
    }
    private var header:some View{
        ZStack{
            HStack(alignment:.bottom){
                Button {
                    isActive = false
                } label: {
                    Image(systemName:"chevron.left")
                        .padding(.leading)
                }
                Spacer()
                Button {
                    isProgress = true
                    if let data = post.selectPhotoItem.first{
                        if let image = UIImage(data: data){
                            if vmAuth.user != nil{
                                if let user = vmAuth.user{
                                    vmPost.posting(nickName: user.nickname ,title: text, catergoryValue: category.title, diary: diary, image:image,long: vmMap.mapView.region.center.longitude,lat: vmMap.mapView.region.center.latitude)
                                }
                            }
                        }
                    }
                    
                } label: {
                    Text("완료").font(.callout).bold()
                        .padding(.trailing)
                }.onReceive(vmPost.postSuccess) { postingSuccess in
                    isProgress = !postingSuccess
                    isActive = !postingSuccess
                }
            }
            Text("게시물 작성").bold().frame(maxWidth: .infinity,alignment: .center)
        }
        .font(.title3)
        .foregroundColor(.white)
        .padding(.top,10)
    }
    private func diaryText()->some View{
        VStack(spacing: 0){
            TextEditor(text: $diary)
                .frame(height:UIScreen.photoWidth)
                .scrollContentBackground(.hidden)
                .foregroundColor(.black)
                .padding()
                .padding(.trailing)
            
        }
    }
}
