//
//  MapViewHelper.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/11.
//

import SwiftUI
import UIKit
import MapKit

struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var vmMap:MapViewModel
    func makeUIView(context: Context) -> MKMapView {
        return vmMap.mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
