////
////  LocationTrackerViewModel.swift
////  SODASER
////
////  Created by 유영웅 on 2023/02/16.
////
//
//import Foundation
//import MapKit
//import CoreLocation
//import Combine
//
//final class LocationTrackerViewModel:NSObject,CLLocationManagerDelegate,ObservableObject{
//    
//    let manager = CLLocationManager()
//    var timer: Timer?
//    var cancellable = Set<AnyCancellable>()
//    var regionSuccess = PassthroughSubject<(),Never>()
//    let dateFormatter: String = {
//        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
//        df.timeZone = TimeZone(abbreviation: "KST")
//        df.dateFormat = "yyyy_MM_dd"
//        return df.string(from: Date())
//    }()
//    @Published var locations = [CLLocation]()
//    @Published var annotations: [MKPointAnnotation] = []
//    @Published var locationList: [LocationLog] = []
//    @Published var recordingMod = false
//    
//    override init(){
//        super.init()
//        self.manager.delegate = self
//        self.manager.distanceFilter = 10 //위치 업데이트 최선 거리 (M단위)
//        self.manager.requestAlwaysAuthorization()    //앱이 서스펜스상태일때 위치 정보 수신
//        self.manager.allowsBackgroundLocationUpdates = true  //locationManager가 위치정보 수신을 중단하는 걸 허용
//        self.manager.desiredAccuracy = kCLLocationAccuracyBest       //정확도 최고
//        self.manager.startUpdatingLocation() //위치정보 업데이트
//        
//    }
//    func startTimer(user:UserData){
//        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            let date = Date()
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.hour, .minute, .second], from: date)
//            let hour = components.hour ?? 0
//            let minute = components.minute ?? 0
//            let second = components.second ?? 0
//            print("\(hour)시 \(minute)분 \(second)초")
//            if hour == 0 && minute == 0 && second == 0{
////                DataUploader.uploadLocation(dateFormatter: self.dateFormatter, path: "locationLog", nickName: "\(user.email)") { responseUrl in
////                    UserApiService.locationTracker(url: responseUrl)
////                        .sink { completion in
////                            print("completion \(completion)")
////                        } receiveValue: { receivedValue in
////                            self.locationList = receivedValue
////                        }.store(in: &self.cancellable)
////                }
//            }
//        }
//        self.timer?.fire()
//    }
//    func stopTimer() {
//        self.timer?.invalidate()
//        self.timer = nil
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let lat = locations.first?.coordinate.latitude,
//              let long = locations.first?.coordinate.longitude else {
//            return
//        }
//        print("didUpdateLocations - 위도: \(lat), 경도: \(long)")
//        
//        self.locations.append(contentsOf: locations)
//            
//            // 파일에 위치 데이터 저장
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let fileURL = dir.appendingPathComponent(dateFormatter + ".txt")
//                let locationString = locations.map { "\($0.coordinate.latitude),\($0.coordinate.longitude)" }.joined(separator: "\n")
//                do {
//                    try locationString.write(to: fileURL, atomically: false, encoding: .utf8)
//                } catch {
//                    print("Error writing location data: \(error)")
//                }
//            }
//        }
////    func saveAnnotations() {
////
////        let fileManager = FileManager.default
////        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else{ return }
////        let annotationFileURL = url.appendingPathComponent("\(dateFormatter)annotations.txt")   //url 지정
////
////        //배열 지정후 annotation 저장
////        var annotationStrings: [String] = []
//////        let annotation = MKPointAnnotation()
////
//////        annotation.coordinate = location.coordinate
//////        let annotationString = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
//////        annotationStrings.append(annotationString)
////        for annotation in annotations{
////            let annotationString = "\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)"
////            annotationStrings.append(annotationString)
////        }
////        //저장된 배열 파일매니저에 저장
////        let annotationsString = annotationStrings.joined(separator: "\n")
////        do {
////            try annotationsString.write(to: annotationFileURL, atomically: true, encoding: .utf8)
////            print("Annotation 저장 완료")
////        } catch {
////            print("Annotation 저장 실패: \(error)")
////        }
////    }
////
////    func addAnnotation(location: CLLocationCoordinate2D) {
////
////        let fileManager = FileManager.default
////        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else{ return }
////        let annotationFileURL = url.appendingPathComponent("\(dateFormatter)annotations.txt")   //url 지정
////
////        let annotationString = "\(location.latitude),\(location.longitude)"
////
//////        let annotation = MKPointAnnotation()
//////        annotation.coordinate = location
//////        self.annotations.append(annotation)
////
////    }
////
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        print("위치목록 \(locations)")
////        guard let location = locations.last?.coordinate else {return}
////        self.addAnnotation(location:location)
////    }
//}
