//
//  MapView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/09.
//

import SwiftUI
import MapKit
import CoreLocationUI
import Combine

struct MapView: View {
    let isView:Bool     //지도 사용
    let mod:Bool        //포스팅 유무
    @State var region = MKCoordinateRegion()
    @StateObject var vm = MainViewModel()
    @StateObject var vmMap = MapViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Map(coordinateRegion:mod ? $vmMap.mapView.region:$region,showsUserLocation: isView).ignoresSafeArea()
            if isView{
                GPSButton.padding(.leading).padding(.bottom)
            }
        }.onReceive(vm.regionSuccess){
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
            }
        }
        
    }
    var GPSButton : some View{
        LocationButton(.currentLocation){
            vm.cheackLocation()
        }
        .labelStyle(.iconOnly)
        .foregroundColor(.red)
        .symbolVariant(.fill)
        .tint(colorScheme == .light ? .white : .black)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding(.trailing,20)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(isView: false, mod: true).environmentObject(MainViewModel())
    }
}

