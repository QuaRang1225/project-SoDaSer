//
//  PostRowView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/09.
//

import SwiftUI
import Kingfisher
import CoreLocation

struct PostRowView: View {
    
    let post:Post
    let user:UserData
    @State var myCity = ""  //도시
    @State var myLocation = ""  //시,도
    @State var heart = false
    @EnvironmentObject var vmPost:PostViewModel
    
    var body: some View {
            ZStack{
//                if let savedImage = LocalFileManager.instance.getImage(imageName:String(describing: post.id), folderName: vmPost.imageFolderName){
//                    Image(uiImage: savedImage)
//                        .resizable()
//                        .modifier(CustiomModifier(width: 400, height:  500, radius: 0)) //190,250
//                        .clipShape(RoundedShape(corners:[ .topLeft,.topRight],width: 10,height: 10))
//                }
//                else{
//                    KFImage(URL(string: post.image))
//                        .placeholder{
//                            Color.white
//                                .overlay{
//                                    Image(systemName: "xmark")
//                                        .font(.title)
//                                }
//                        }
//                        .cancelOnDisappear(true)
//                        .cacheMemoryOnly()
//                        .loadDiskFileSynchronously()
//                        .resizable()
//                        .modifier(CustiomModifier(width: 400, height:  500, radius: 0)) //190,250
//                        .clipShape(RoundedShape(corners:[ .topLeft,.topRight],width: 10,height: 10))
//                }
            }.overlay {
                VStack(alignment:.leading){
                    Spacer()
                   
                    Spacer()
                    VStack(alignment: .leading,spacing: 5){
                        HStack{

                            KFImage(URL(string: user.profileImage ?? ""))
                                .cancelOnDisappear(true)
                                .cacheMemoryOnly()
                                .loadDiskFileSynchronously()
                                .resizable()
                                .modifier(CustiomModifier(width: 35, height:  35, radius: 10))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading){
                                Text(user.nickname)
                                
                            }.font(.callout).bold()
                            Spacer()
                            Text("\(Date().relativeTime(postingDate: Date().StringToDate(stringDate: post.createTime)))").foregroundColor(.gray).font(.caption)
                            
                            
                        }.padding(.trailing,5)
                            .padding(.vertical,10)
                        HStack{
                            Text(post.title).font(.subheadline).bold()
                            //Spacer()
                            Text(post.category ?? "없음").font(.caption2)
                            Spacer()
                        }
                        HStack(alignment: .bottom, spacing:3){
                            Text(myCity).bold().font(.caption)
                            Text(myLocation).font(.caption2)
                        }.foregroundColor(.gray)
                            .padding(.bottom,5)
                    }.padding(.horizontal,10)
                        .padding(.vertical,10)
                        .background(Color.white).clipShape(RoundedShape(corners:[ .bottomLeft,.bottomRight],width: 10,height: 10)).offset(y:30)
                }.foregroundColor(.black)
                
            }
        
        .onAppear{
            setLocation(lat: NSDecimalNumber(decimal:post.latitude).doubleValue, long: NSDecimalNumber(decimal:post.longitude).doubleValue, user:  CustomPreView.instance.user)
            
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
                    vmPost.downloadImage(imageUrl: post.image, id: String(describing: post.id), location:"\(city) \(name)",profileUrl:user.profileImage ?? "")
                }
            }
        })
        
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            PostRowView(post: CustomPreView.instance.postView.first!, user: CustomPreView.instance.user)
                .environmentObject(PostViewModel())
        }
    }
}

