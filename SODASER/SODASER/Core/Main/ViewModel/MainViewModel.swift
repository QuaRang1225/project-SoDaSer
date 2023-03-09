
//
//  MapViewModel.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/22.
//

import SwiftUI
import UIKit
import MapKit
import CoreLocation
import Combine


final class MainViewModel:NSObject,CLLocationManagerDelegate,ObservableObject{
    
    private var manager = CLLocationManager()
    var mySpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    var regionSuccess = PassthroughSubject<(),Never>()
    
    //@Published var mapRegion = MKCoordinateRegion()
    @Published var mapCoordinate = CLLocationCoordinate2D()
    
    
    
    
    override init() {
        super.init()
        DispatchQueue.global(qos: .background).async {
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyBest   //정확도 최고로 설정
            self.manager.requestWhenInUseAuthorization() //앱 사용중과 관계 없이 위치서비스 사용자권한 요청
            self.manager.startUpdatingLocation()
            DispatchQueue.main.async{
                self.regionSuccess.send()
            }
        }
        
    }

    
    func cheackLocation(){
        DispatchQueue.global(qos: .background).async {
            // 백그라운드 스레드에서 모델 업데이트
            if CLLocationManager.locationServicesEnabled(){
                self.manager = CLLocationManager()
                self.manager.delegate = self
            }else{
                print("지도가 꺼져있음")
            }
            // 메인 스레드에서 변경 사항 처리
            DispatchQueue.main.async{
                self.regionSuccess.send()
            }
        }
        
        
    }
    func cheackLocationAuthrization(){
            switch self.manager.authorizationStatus{
            case .notDetermined:
                self.manager.requestAlwaysAuthorization()
            case .restricted:
                print("위치정보 제한")
            case .denied:
                print("위치정보 거부")
            case .authorizedAlways, .authorizedWhenInUse:
                DispatchQueue.main.async {
                    self.mapCoordinate = self.manager.location!.coordinate
                }
            @unknown default:
                break
            }
        
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        self.cheackLocationAuthrization()
        regionSuccess.send()
    }
    
    
}



