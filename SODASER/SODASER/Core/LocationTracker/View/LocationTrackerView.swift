////
////  LocationTrackerView.swift
////  SODASER
////
////  Created by 유영웅 on 2022/12/29.
////
//
//import SwiftUI
//import MapKit
//import CoreLocationUI
//
//extension CLLocation: Identifiable { }   //Identifiable 프로토콜 준수시킴
//
//struct LocationTrackerView: View {
//
//    @AppStorage("locationRecord") var isButtonClick = false
//    @State var region = MKCoordinateRegion()
//    @StateObject var vm = MainViewModel()
//    @EnvironmentObject var vmAuth:AuthenticationViewModel
//    @StateObject var vmTracker = LocationTrackerViewModel()
//    @State private var directions: [String] = []
//    @Environment(\.colorScheme) var colorScheme
//
//    var body: some View {
//        ZStack(alignment: .bottom){
////            Map(
////                coordinateRegion: $region,showsUserLocation: true,annotationItems: vmTracker.locations) { routeLocation in
////                    MapAnnotation(coordinate: routeLocation.coordinate,anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
////                        Circle().fill(Color.sodaPrimary)
////
////                    }
////                    //MKPolyline(coordinates: &routeLocation.coordinate, count: 3)
////                }
////                .ignoresSafeArea()
//            HeaderView(title: "위치 로그").frame(maxHeight: .infinity,alignment: .top)
//            HStack(spacing: 0){
//                GPSButton
//                Spacer()
//                logButton
//            }.padding(.horizontal)
//
//        }
//        .onReceive(vm.regionSuccess){
//            DispatchQueue.main.async {
//                withAnimation(.easeIn(duration: 0.5)){
//                    region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
//                }
//            }
//        }
//        .onAppear{
//            vmTracker.recordingMod = $isButtonClick.wrappedValue
//            print("위치 저장 모드 \(vmTracker.recordingMod)")
//        }
//    }
//    var GPSButton : some View{
//        LocationButton(.currentLocation){
//            vm.cheackLocation()
//        }
//        .labelStyle(.iconOnly)
//        .foregroundColor(.red)
//        .symbolVariant(.fill)
//        .tint(colorScheme == .light ? .white : .black)
//        .cornerRadius(10)
//        .shadow(radius: 20)
//        .padding(.trailing,20)
//    }
//    var logButton:some View{
//        ZStack(alignment: .leading){
//            Color.antiPrimary
//                .cornerRadius(10).frame(width: 170,height: 45).overlay {
//                    Text(vmTracker.recordingMod ? "위치기록 중..":"위치기록 중단됨")
//                        .foregroundColor(.secondary).frame(maxWidth: .infinity,alignment: .trailing).padding()
//                }
//            if vmTracker.recordingMod{
//                RoundedRectangle(cornerRadius: 2).frame(width: 18,height: 18).foregroundColor(.red).padding(.leading,12)
//            }else{
//                Image(systemName: "arrowtriangle.right.fill").foregroundColor(.red).font(.title2).padding(.leading,5).padding(.leading,5)
//            }
//        }
//        .padding(.bottom,5)
//        .onTapGesture {
//            withAnimation(.easeIn){
//                isButtonClick.toggle()
//                vmTracker.recordingMod = $isButtonClick.wrappedValue
//                if vmTracker.recordingMod{
//                    vmTracker.startTimer(user: vmAuth.user?.user ?? CustomPreView.instance.user)
//                }else{
//                    vmTracker.stopTimer()
//                }
//            }
//        }
//    }
//}
//
//struct LocationTrackerView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationTrackerView()//.environmentObject(LocationTrackerViewModel())
//            .environmentObject(AuthenticationViewModel())
//    }
//}
