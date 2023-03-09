//
//  MainView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import SwiftUI
import MapKit
import CoreLocationUI
import Kingfisher

struct MainView: View {
    
    let user:UserData
    @State var selsctActive = false
    @State var mapSize = false
    @State var myCity = ""  //도시
    @State var myLocation = ""  //시,도
    @State var userSearch = false
    @State var post:[Feed] = []
    @State var text:String = ""
    @State var region = MKCoordinateRegion()
    @State var isActive = false //게시물 포스팅
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var vmFollow:FollowerViewModel
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing:0){
                header
                Image("home")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 50)
                    .padding(.leading,30)
                searchBar
                ScrollView{
                    VStack(alignment: .leading,spacing: 0){
                        Image("menu")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,height: 20)
                            .padding(.leading,30)
                            .padding(.bottom,5)
                            .shadow(radius: 10)
                        HStack(spacing:0){
                            mapView.padding(.horizontal,20)
                            if !mapSize{
                                VStack{
                                    Group{
                                        Button {
                                            isActive = true
                                        } label: {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(
                                                    AngularGradient(gradient: Gradient(colors: [Color.whiteGray, Color.whiteCyan2]),
                                                                    center: .topLeading,
                                                                    angle: .degrees(180 + 45))
                                                )
                                                .overlay{
                                                    Text("무엇을 했나요?").bold().foregroundColor(.blackIndigo)
                                                        .padding(.bottom,5)
                                                    HStack(spacing: 0){
                                                        Image("pencil")
                                                            .resizable()
                                                            .frame(width: 70, height:20)
                                                            .scaledToFill()
                                                            .padding(.top,70)
                                                            .padding(.leading,50)
                                                            .offset(x:45)
                                                        Image("pencil")
                                                            .resizable()
                                                            .frame(width: 70, height: 30)
                                                            .scaledToFill()
                                                            .padding(.top,60)
                                                    }
                                                    
                                                }

                                        }.navigationDestination(isPresented: $isActive) {
                                            LocationSelectView(postMod: .constant(true), isActive: $isActive).navigationBarHidden(true)
                                        }
                                        
                                        .padding(.bottom,5)
                                        NavigationLink {
                                            FavoriteView(isActive: $selsctActive)
                                                .onAppear{
                                                    selsctActive = false
                                                }
                                                .environmentObject(vmAuth)
                                        } label: {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(
                                                    AngularGradient(gradient: Gradient(colors: [Color.purple, Color.whiteCyan2]),
                                                                    center: .topLeading,
                                                                    angle: .degrees(180 + 45))
                                                )
                                                .overlay{
                                                    VStack(spacing:10){
                                                        Image(systemName: "star.fill")
                                                            .font(.title3)
                                                        Text("자주가는 곳이 있으신가요?").font(.caption)
                                                    }.foregroundColor(.white).bold()
                                                }
                                        }
                                        .padding(.top,5)
                                        .opacity(mapSize ? 0.0:1.0)
                                    }.padding(.trailing,20)
                                        .shadow(radius: 10)
                                }.frame(height: 200)
                            }
                            
                        }
                    }
                    HStack{
                        Image("feed")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,height: 20)
                            .padding(.top,10)
                            .padding(.leading,20)
                            .shadow(radius: 10)
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        LazyHStack{
                            ForEach(post,id: \.self) { item in
                                NavigationLink {
                                    PostView(post: item.post, user: item.user, region: MKCoordinateRegion(center: item.post.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
                                        .environmentObject(vmPost)
                                        .environmentObject(vmAuth)
                                    
                                } label: {
                                    VStack{
                                        KFImage(URL(string: item.post.image))
                                            .placeholder{
                                                Color.white
                                                    .overlay{
                                                        Image(systemName: "xmark")
                                                            .font(.title)
                                                    }
                                            }
                                            .cancelOnDisappear(true)
                                            .cacheMemoryOnly()
                                            .loadDiskFileSynchronously()
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 300,height: 250)
                                            .clipped()
                                        
                                        VStack(alignment: .leading,spacing:7) {
                                            HStack{
                                                KFImage(URL(string: item.user.profileImage ?? ""))
                                                    .cancelOnDisappear(true)
                                                    .cacheMemoryOnly()
                                                    .loadDiskFileSynchronously()
                                                    .resizable()
                                                    .modifier(CustiomModifier(width: 35, height:  35, radius: 10))
                                                    .clipShape(Circle())
                                                
                                                VStack(alignment: .leading){
                                                    Text(item.user.nickname)
                                                    
                                                }.font(.callout).bold()
                                                Spacer()
                                                Text("\(Date().relativeTime(postingDate: Date().StringToDate(stringDate: item.post.createTime)))").foregroundColor(.gray).font(.caption)
                                            }
                                            HStack{
                                                Text(item.post.title).font(.subheadline).bold()
                                                Text(item.post.category ?? "없음").font(.caption2)
                                            }
                                            HStack(alignment: .bottom, spacing:3){
                                                Text(myCity).bold().font(.caption)
                                                Text(myLocation).font(.caption2)
                                            }.foregroundColor(.gray)
                                                .padding(.bottom,5)
                                        }.padding(10)
                                        
                                    }.background(.white).cornerRadius(20).shadow(radius: 10)
                                        .foregroundColor(.blackIndigo)
                                        .padding(.leading,20)
                                        .padding(.vertical,20)
                                        .onAppear{
                                            setLocation(lat: NSDecimalNumber(decimal:item.post.latitude).doubleValue, long: NSDecimalNumber(decimal:item.post.longitude).doubleValue, user:  CustomPreView.instance.user)
                                        }
                                }
                            }
                        }
                    }//.frame(height: 400)
                }
                
                
                
                .refreshable {
                    vmPost.feedList()
                }
            }.background(content: {
                ZStack(alignment: .bottom){
                    Color.whiteGray
                    RoundedShape(corners: [.topLeft], width: 100, height: 100)
                        .foregroundColor(.white)
                        .frame(height: 700)
                        
                }
            })
            .ignoresSafeArea()
            .onReceive(vmPost.listViewSuccess){
                DispatchQueue.main.async {
                    post = vmPost.feed
                }
            }
            
        }.onAppear{
            DispatchQueue.global(qos: .background).async {
                vmPost.feedList()
                vmFollow.usersInfo()
            }
        }
    }
    func setLocation(lat:Double,long:Double,user:UserData){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let city = address.last?.locality,let name = address.last?.name{
                    myCity = city
                    myLocation = name
                }
            }
        })
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: CustomPreView.instance.user, post: CustomPreView.instance.feedView)
            .environmentObject(AuthenticationViewModel())
            .environmentObject(PostViewModel())
            .environmentObject(FollowerViewModel())
        
    }
}

extension MainView{
    var header:some View{
        HStack(spacing: 20){
            Spacer()
            NavigationLink {
                ProfileView(user: user,logOut: $vmAuth.loginMode)
                    .environmentObject(vmPost)
                    .environmentObject(vmAuth)
            } label: {
                if let profileImage = vmAuth.user?.profileImage{
                    KFImage(URL(string: profileImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40,height: 40)
                        .clipShape(Circle())
                        .overlay{
                            Circle().stroke(.primary,lineWidth: 2)
                        }
                }else{
                    DummyCircle(width: 40, height: 40)
                }
            }
            NavigationLink {
                NotificationView()
            } label: {
                Image(systemName: "bell.fill").font(.title)
            }
        }.foregroundColor(.white)
            .padding(.trailing,30)
            .bold().shadow(radius: 15).padding(.top,50)
    }
    var mapView:some View{
        Button {
            DispatchQueue.main.async {
                withAnimation(.default){
                    mapSize.toggle()
                }
            }
        } label: {
            Map(coordinateRegion: $region,interactionModes: [],userTrackingMode: .constant(.follow))
                .frame(width:mapSize ? .infinity:200,height: mapSize ? 400: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                .onReceive(vm.regionSuccess) {
                    DispatchQueue.main.async {
                        region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
                    }
                }
                .overlay {
                    Group{
                        Image(systemName: "location.north.fill")
                            .foregroundColor(.cyan)
                        Image(systemName: "location.north")
                            .foregroundColor(.white)
                    }
                    .font(.title)
                    .shadow(radius: 10)
                }
        }
        
    }
    var searchBar:some View{
        NavigationLink {
            AllUsersView(user: user).environmentObject(vmFollow)
        } label: {
            CustomInputView(imageName: "magnifyingglass", placeholderText: " 사용자 검색..", imageColor: .gray, text: $text)
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding(.vertical)
        .padding(10)
        .shadow(radius: 10)
    }
}
