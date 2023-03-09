//
//  PostView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/02.
//

import SwiftUI
import MapKit
import Kingfisher

struct PostView: View {
    
    let post:Post
    let user:UserData
    
    @State var isMapView = false
    @State var text = ""    //댓글
    @State var myCountry = ""   //나라
    @State var myCity = ""  //도시
    @State var myLocation = ""  //시,도
    @State var region:MKCoordinateRegion
    @StateObject var vm = MainViewModel()
    @StateObject var vmkeyboard = KeyboardHandler()
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack{
                Color.white.ignoresSafeArea()
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .bold()
                                .font(.title3)
                                .shadow(color: .black, radius: 20)
                        }.padding(.leading).padding(.bottom,20)
                        Spacer()
                    }
                    
                    
                    mainView
                
                }
               
                if isMapView{
                    Color.black.opacity(0.8).ignoresSafeArea()
                    VStack(alignment: .leading,spacing: 5){
                        Group{
                            HStack{
                                Image(systemName: "chevron.left").padding()
                                VStack(alignment: .leading){
                                    Text(myCountry).font(.title3)
                                    HStack{
                                        Text(myCity)
                                        Text(myLocation)
                                    }
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .padding(.leading,5)
                        .bold()
                        Map(coordinateRegion: $region, annotationItems: [post]){ item in
                            MapAnnotation(coordinate: item.coordinate){
                                MapPinView(user: user, postingImage: nil)
                            }
                        }.ignoresSafeArea()
                    }
                }
            }
            .foregroundColor(.blackIndigo)
            .onTapGesture {
                UIApplication.shared.endEditing()
                isMapView = false
            }
            .onAppear{
                setLocation(lat: NSDecimalNumber(decimal:post.latitude).doubleValue, long: NSDecimalNumber(decimal:post.longitude).doubleValue)
            }
        .navigationBarHidden(true)
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: CustomPreView.instance.postView.first!, user: CustomPreView.instance.user, region:MKCoordinateRegion())
            .environmentObject(AuthenticationViewModel())
            .environmentObject(PostViewModel())
    }
}
extension PostView{
    func setLocation(lat:Double,long:Double){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let contry = address.last?.country{
                    self.myCountry = contry
                }
                if let city = address.last?.locality{
                    self.myCity = city
                }
                if let name = address.last?.name {
                    self.myLocation = name
                } //전체 주소
            }
        })
        
    }
    var mainView:some View{
        
                
                VStack(spacing: 0){
                    ScrollView{
                        KFImage(URL(string:post.image)!)
                            .placeholder{
                                Color.white
                                    .overlay{
                                        Image(systemName: "xmark")
                                            .font(.title)
                                    }
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400,height: 400)
                            .clipped()
                            .shadow(radius: 10)
                            .overlay(alignment: .bottom){
                                HStack(alignment: .bottom){
                                    KFImage(URL(string: user.profileImage ?? ""))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40,height: 40)
                                        .clipShape(Circle())
                                        .padding(.horizontal,10)
                                    VStack(alignment: .leading,spacing: 5) {
                                        Text(user.name)
                                        Text(Date().DatetoString(stringDate: Date().StringToDate(stringDate: post.createTime)))
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }.bold()
                                    Spacer()
                                    HStack(spacing:0){
                                        Image(systemName: "pin")
                                        Text("위치").bold().foregroundColor(.white).padding(.horizontal,5)
                                        Text(myLocation)
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.5)){
                                                    isMapView = true
                                                }
                                            }
                                    }.font(.caption).padding(.trailing)
                                }.bold()
                                    .padding(.vertical)
                                    .background(Color.black.opacity(0.7))
                                    .foregroundColor(.white)
                            }.cornerRadius(20)
                            .shadow(radius: 10,y: 10)
                        HStack{
                            Text(post.title)
                                .font(.title2)
                                .bold()
                            Text(post.category ?? "없음").font(.subheadline)
                            Spacer()
                            Image(systemName: "heart")
                                .font(.title)
                        }.padding(.horizontal)
                        HStack{
                            Text(post.contents).multilineTextAlignment(.leading).padding(.vertical)
                            Spacer()
                        }
                            .padding(.horizontal)
                        Divider().padding(.horizontal)
                        
                    }
                    HStack{
                        KFImage(URL(string: vmAuth.user?.profileImage ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40,height: 40)
                            .clipShape(Circle())
                            .padding(.leading,15)
                            .shadow(radius: 10)
                        CustomInputView(imageName: nil, placeholderText: "댓글달기 ..", imageColor: .blackIndigo, text: $text).padding(.leading)
                        if text != ""{
                            Button {
                                vmPost.reply(text: text, endPoint: "\(String(describing: post.id))")
                            } label: {
                                Text("전송")
                                    .bold()
                                    .padding(.trailing)
                            }
                        }
                        
                    }.padding(.vertical,10)
                        .padding(.bottom,20)
                }
           // }
            
            
        
        
    }
}
