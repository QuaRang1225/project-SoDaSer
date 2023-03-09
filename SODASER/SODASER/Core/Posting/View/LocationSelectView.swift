//
//  PostingView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/10.
//

import SwiftUI
import MapKit



struct LocationSelectView: View {
    
    //    @State var myCity = ""  //도시
    //    @State var myLocation = ""  //시,도
    @Binding var postMod:Bool
    @Binding var isActive:Bool
    @State var isSelect = false
    @State var region = MKCoordinateRegion()
    @State var navigationTag:String?
    @StateObject var vm = MainViewModel()
    @StateObject var vmMap = MapViewModel()
    
   
    
    var body: some View {
            ZStack{
                MapView(isView: false, mod: false)
                Color.black.opacity(0.5).ignoresSafeArea()
                mainView
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isSelect){
                LocationMapView(isActive: $isActive, isPostMod: $postMod).environmentObject(vm).environmentObject(vmMap)
            }
        
        .navigationBarBackButtonHidden()
        .onAppear{
            vmMap.searchText = ""
        }
    }
}

struct LocationSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectView(postMod: .constant(true), isActive: .constant(true))
    }
}

extension LocationSelectView{
    var mainView:some View{
        VStack(spacing: 10){
            ZStack{
                HStack{
                    Button {
                        isActive = false
                    } label: {
                        Image(systemName:"chevron.left")
                            .padding(.leading)
                    }
                    Spacer()
                }
                
                Text("위치 검색").bold().frame(maxWidth: .infinity,alignment: .center)
            }
            .font(.title3)
            .foregroundColor(.white)
            .padding(.top,10)
            CustomInputView(imageName: "magnifyingglass", placeholderText: "위치 검색 ..", imageColor: .white, text: $vmMap.searchText).padding()
            if let place = vmMap.fetchPlace, !place.isEmpty{
                List{
                    ForEach(place,id: \.self){ place in
                        Button {
                            if let coordinate = place.location?.coordinate{
                                vmMap.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                vmMap.addDraggablePin(coordinate: coordinate)
                                vmMap.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
//                                vmMap.saveLocationList(loc: coordinate, city: place.locality ?? "", locality: place.name ?? "", mod: postMod)
                                isSelect = true
                            }
                        } label: {
                            HStack(spacing:15){
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                VStack(alignment: .leading){
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }.listRowBackground(Color.clear)
                }.listStyle(.plain)
                    .scrollContentBackground(.hidden)
            }else{
                HStack{
//                    if !vmMap.fetchPlaceLog.isEmpty{
//                        Button {
//                            vmMap.removeList(mod: postMod)
//                        } label: {
//                            HStack{
//                                Image(systemName: "trash")
//                                Text("기록 모두지우기")
//                            }.foregroundColor(.white).bold().font(.caption)
//                        }.padding(.leading)
//                    }
                    
                    Button {
                        //setLocation(lat: region.center.latitude, long: region.center.longitude)
                        vmMap.addDraggablePin(coordinate: region.center)
                        vmMap.updatePlacemark(location: .init(latitude: region.center.latitude, longitude: region.center.longitude))
                        isSelect = true
                    } label: {
                        Label {
                            Text("현재 위치")
                                .font(.callout)
                        } icon: {
                            Image(systemName: "mappin.circle.fill")
                        }.foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .trailing).padding(.trailing)
                    }
                }
//                if let list = vmMap.fetchPlaceLog,!vmMap.fetchPlaceLog.isEmpty{
//                    List{
//                        ForEach(Array(list.enumerated()).reversed(),id:\.offset){ index,location in  //값과 index함께 받기
//                            Button {
//                                setLocation(lat: location.latitude, long: location.longitude)
//                                vmMap.pickedLocation = .init(latitude: location.latitude, longitude: location.longitude)
//                                vmMap.addDraggablePin(coordinate: location)
//                                vmMap.updatePlacemark(location: .init(latitude: location.latitude, longitude: location.longitude))
//                                isLocationSuccess = true
//                            } label: {
//                                HStack(spacing:15){
//                                    Image(systemName: "clock.arrow.circlepath")
//                                        .font(.title2)
//                                        .foregroundColor(.white)
//                                    VStack(alignment: .leading){
//                                        Text(vmMap.localitys[index])
//                                            .foregroundColor(.white)
//                                            .font(.title3.bold())
//                                        Text(vmMap.citys[index])
//                                            .font(.caption)
//                                            .foregroundColor(.white)
//                                    }
//                                }
//                            }
//                        }.listRowBackground(Color.clear)
//                    }.listStyle(.plain).scrollContentBackground(.hidden)
//
//                }
            }
            
            
        }
        .frame(maxHeight: .infinity,alignment: .top)
        .onReceive(vm.regionSuccess) {
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
            }
        }
        .onAppear{
            //vmMap.getLocationList(mod: postMod)
            print("\(postMod)")
        }
    }
//    func setLocation(lat:Double,long:Double){
//        let findLocation = CLLocation(latitude: lat, longitude: long)
//        let geocoder = CLGeocoder()
//        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
//        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
//            if let address: [CLPlacemark] = placemarks {
//                if let city = address.last?.locality,let name = address.last?.name{
////
////                    vmMap.saveLocationList(loc: CLLocationCoordinate2D(latitude: lat, longitude: long), city: city, locality: name, mod: postMod)
//                    //                    self.myCity = city
//                    //                    self.myLocation = name
//                    //                    vmPost.downloadImage(imageUrl: post?.image ?? "", id: String(describing: post?.id), location:"\(city) \(name)",profileUrl:user?.profileImage ?? "")
//                }
//            }
//        })
//
//    }
}

