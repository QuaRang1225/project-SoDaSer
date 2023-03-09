//
//  ContentView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
       var body: some View {
           ZStack{
               Map(coordinateRegion: $region).ignoresSafeArea()
               
           }
       }
}
extension

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
