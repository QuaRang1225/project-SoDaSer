//
//  LocationMapView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/10.
//

import SwiftUI
import MapKit

struct LocationMapView:View{
    
    @State var isLocationSuccess = false
    @Binding var isActive:Bool
    @Binding var isPostMod:Bool
    @StateObject var vmPost:PostViewModel = .init()
    @EnvironmentObject var vmMap:MapViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    var body: some View{
        ZStack(alignment: .top){
            MapViewHelper().environmentObject(vmMap).ignoresSafeArea()
            HeaderView(title: "위치검색")
            HStack{
                Button {
                    isActive = false
                } label: {
                    Image(systemName:"chevron.left")
                        .padding(.top)
                        .padding(.leading).foregroundColor(.white)
                }
                Spacer()
            }
            if let place = vmMap.pickedPlaceMark{
                rowView(place: place)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .onDisappear{
            vmMap.pickedLocation = nil
            vmMap.pickedPlaceMark = nil
            vmMap.mapView.removeAnnotations(vmMap.mapView.annotations)
        }
    }
}
struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView(isActive: .constant(true), isPostMod: .constant(true)).environmentObject(MainViewModel()).environmentObject(MapViewModel())
    }
}
extension LocationMapView{
    
    func rowView(place:CLPlacemark) -> some View{
        VStack{
            Text("위치 확인")
                .font(.title2.bold())
                .foregroundColor(.white)
            HStack(alignment: .top){
                Image(systemName: "mappin.circle.fill")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.7))
                VStack(alignment: .leading){
                    Text(place.name ?? "").font(.title3.bold()).foregroundColor(.white.opacity(0.7))
                    Text(place.locality ?? "").font(.caption).foregroundColor(.white.opacity(0.7))
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom,10)
                Button {
                    isLocationSuccess = true
                    vmPost.locationSet(locationName: place.name ?? "", cityName: place.locality ?? "")
                } label: {
                    Text("위치 확인")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,maxHeight: 40)
                        .background{
                            RoundedRectangle(cornerRadius: 10,style: .continuous).fill(.white)
                        }
                        .overlay(alignment:.trailing){
                            Image(systemName: "arrow.right")
                                .font(.title3.bold())
                                .padding(.trailing)
                        }
                        .foregroundColor(.black)
                }.navigationDestination(isPresented: $isLocationSuccess){
                    if isPostMod{
                        TabImageView(isActive: $isActive, coordinate: place.location?.coordinate ?? CLLocationCoordinate2D())
                            .environmentObject(vmAuth)
                            .environmentObject(vmMap)
                    }else{
                        FavoriteSaveView(isActive: $isActive, coordinate: place.location?.coordinate ?? CLLocationCoordinate2D(), city: place.locality ?? "" , location: place.name ?? "").environmentObject(vmMap)
                    }
                    
                }
            }.padding(.bottom)
        }
        .padding()
        .background{
            Color.black.opacity(0.5).ignoresSafeArea()
        }.frame(maxHeight: .infinity,alignment: .bottom)
    }
}
