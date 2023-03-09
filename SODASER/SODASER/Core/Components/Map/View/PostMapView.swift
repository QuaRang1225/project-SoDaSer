//
//  PostMapView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/18.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct PostMapView: View {
    
    let user:UserData
    @State var region = MKCoordinateRegion()
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = MainViewModel()
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Map(coordinateRegion: $region,showsUserLocation: true, annotationItems: vmPost.post){ item in
                MapAnnotation(coordinate: item.coordinate){
                    NavigationLink {
                        PostView(post: item, user: user, region: MKCoordinateRegion(center: item.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
                            .environmentObject(vm)
                            .environmentObject(vmPost)
                    } label: {
                        MapPinView(user: user, postingImage: item.image)
                            .environmentObject(vmAuth)
                    }
                }
                
            }.ignoresSafeArea()
            GPSButton.padding()
        }
        .onAppear{
            vmPost.postList(email: user.email)
        }
        .onReceive(vm.regionSuccess){
            DispatchQueue.main.async {
                withAnimation(.easeIn(duration: 0.5)){
                    region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
                }
            }
            
        }
        
    }
    
}

struct PostMapView_Previews: PreviewProvider {
    static var previews: some View {
        PostMapView(user: CustomPreView.instance.user).environmentObject(MainViewModel())
            .environmentObject(AuthenticationViewModel())
            .environmentObject(PostViewModel())
    }
}

extension PostMapView{
    var GPSButton : some View{
        LocationButton(.currentLocation){
            vm.cheackLocation()
        }
        .labelStyle(.iconOnly)
        .foregroundColor(.blue)
        .symbolVariant(.fill)
        .tint(colorScheme == .light ? .white : .black)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(.trailing,20)
    }
}
