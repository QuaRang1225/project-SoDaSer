//
//  MapViewModel.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/13.
//

import Foundation
import SwiftUI
import UIKit
import MapKit
import CoreLocation
import Combine

final class MapViewModel:NSObject,MKMapViewDelegate,ObservableObject,CLLocationManagerDelegate{
    
    var mySpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    var cancellable:AnyCancellable?
    var dict = [String:Bool]()
    private var manager = CLLocationManager()
    
    @Published var mapCoordinate = CLLocationCoordinate2D()
    @Published var mapRegion = MKCoordinateRegion()
    @Published var searchText = ""
    @Published var mapView = MKMapView()
    @Published var fetchPlace:[CLPlacemark]?
    
    @Published var userLocation:CLLocation?
    
    @Published var pickedLocation:CLLocation?
    @Published var pickedPlaceMark:CLPlacemark?
    
    @Published var fetchPlaceLog:[CLLocationCoordinate2D] = []
    @Published var citys:[String] = []
    @Published var localitys:[String] = []
    
    override init() {
        super.init()
        mapView.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest   //정확도 최고로 설정
        manager.delegate = self
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != ""{
                    self.fetchPlaces(value: value)
                }else{
                    self.fetchPlace = nil
                }
            })
    }
    
    
    func fetchPlaces(value:String){
        Task{
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = value.lowercased()
            let response = try? await MKLocalSearch(request: request).start()
            await MainActor.run(body: {
                self.fetchPlace = response?.mapItems.compactMap({ item -> CLPlacemark? in
                    return item.placemark
                })
            })
        }
    }
    
    func addDraggablePin(coordinate:CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "게시물 위치"
        mapView.addAnnotation(annotation)
        mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "")
        marker.isDraggable = true
        marker.canShowCallout = false
        return marker
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else{return}
        self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.latitude)
        updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
    func reverseLocationCoordinate(location:CLLocation)async throws -> CLPlacemark?{
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
    
    func updatePlacemark(location:CLLocation){
        Task{
            guard let place = try? await reverseLocationCoordinate(location: location) else {return}
            await MainActor.run(body: {
                self.pickedPlaceMark = place
            })
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else{return}
        self.userLocation = currentLocation
    }
//    func saveLocationList(loc:CLLocationCoordinate2D,city:String,locality:String,mod:Bool){
//
//
//        fetchPlaceLog.append(loc)
//        citys.append(city)
//        localitys.append(locality)
//        print("1\(fetchPlaceLog)")
//        print("1\(citys)")
//        print("1\(localitys)")
//        print()
//        var lat:[Double] = []
//        var long:[Double] = []
//
////        var localitysClone:[String] = []
////        var citysClone:[String] = []
////        var latClone:[Double] = []
////        var longClone:[Double] = []
//
//        for data in fetchPlaceLog{
//            long.append(data.longitude)
//            lat.append(data.latitude)
//        }
//        print()
//        print(localitys)
//        print(citys)
//        print(lat)
//        print(long)
//        if !localitys.isEmpty{
//            if localitys != localitys.uniqued(){
//                localitys.removeLast()
//                citys.removeLast()
//                lat.removeLast()
//                long.removeLast()
//            }
//        }
//
////        for (index,local) in localitys.enumerated(){
////            if !localitys.isEmpty,dict.updateValue(true, forKey: local) != nil{
////               // locality
//////                localitys.append(localitys[index])
//////                citys.append(citys[index])
//////                lat.append(lat[index])
//////                long.append(long[index])
//////                localitysClone.append(localitys[index])
//////                citysClone.append(citys[index])
//////                latClone.append(lat[index])
//////                longClone.append(long[index])
//////                localitys.removeLast()
//////                citys.removeLast()
//////                lat.removeLast()
//////                long.removeLast()
////                print(local)
////                print(index)
////            }
////        }
//
//
//
//        UserDefaults.standard.set(long, forKey: mod ? "locationCoordinateLong" : "locationCoordinateLong1")
//        UserDefaults.standard.set(lat, forKey: mod ? "locationCoordinateLat" : "locationCoordinateLat1")
//        UserDefaults.standard.set(citys, forKey: mod ? "locationCity" : "locationCity1")
//        UserDefaults.standard.set(localitys, forKey: mod ? "locationLocality" : "locationLocality1")
//
//
//
//
////        citys = []
////        localitys = []
////        print(localitysClone.indices)
////        for coordinate in localitysClone.indices{
////            fetchPlaceLog.append(CLLocationCoordinate2D(latitude: latClone[coordinate], longitude: longClone[coordinate]))
////        }
////        citys = citysClone
////        localitys = localitysClone
//        print()
//        print("위치\(fetchPlaceLog)")
//        print("도시\(citys)")
//        print("주소\(localitys)")
//    }
//
//    func getLocationList(mod:Bool){
//
//
//        var coordinateLong:[Double] = []
//        var coordinateLat:[Double] = []
//        for long in (UserDefaults.standard.array(forKey: mod ? "locationCoordinateLong" : "locationCoordinateLong1") as? [Double] ?? []){
//            coordinateLong.append(long)
//        }
//        for lat in (UserDefaults.standard.array(forKey: mod ? "locationCoordinateLat" : "locationCoordinateLat1") as? [Double] ?? []){
//            coordinateLat.append(lat)
//        }
//        fetchPlaceLog = []
//        for coordinate in coordinateLong.indices{
//            fetchPlaceLog.append(CLLocationCoordinate2D(latitude: coordinateLat[coordinate], longitude: coordinateLong[coordinate]))
//        }
//        citys = (UserDefaults.standard.array(forKey: mod ? "locationCity" : "locationCity1") as? [String] ?? [])
//        localitys = (UserDefaults.standard.array(forKey: mod ? "locationLocality": "locationLocality1") as? [String] ?? [])
//
//
//        print("불러오기 위치\(fetchPlaceLog)")
//        print("불러오기 도시\(citys)")
//        print("불러오기 주소\(localitys)")
//
//    }
//    func removeList(mod:Bool){
//        UserDefaults.standard.removeObject(forKey: mod ? "locationCoordinateLong" : "locationCoordinateLong1")
//        UserDefaults.standard.removeObject(forKey: mod ? "locationCoordinateLat" : "locationCoordinateLat1")
//        UserDefaults.standard.removeObject(forKey: mod ? "locationCity" : "locationCity1")
//        UserDefaults.standard.removeObject(forKey: mod ? "locationLocality" : "locationLocality1")
//        fetchPlaceLog = []
//        citys = []
//        localitys = []
//    }
}


//extension Sequence where Element: Hashable {
//    func uniqued() -> [Element] {
//        var set = Set<Element>()
//        return filter { set.insert($0).inserted }
//    }
//}
