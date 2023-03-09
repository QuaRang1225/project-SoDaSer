//
//  FavoriteView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct FavoriteView: View {
    
    @State var favoriteFilter:FavoriteFilter = .food
    @GestureState private var translation: CGFloat = 0
    @StateObject var vm = MainViewModel()
    @StateObject var vmFav = FavoriteViewModel()
    @State var region = MKCoordinateRegion()
    @State var tapCategory = false
    @State var showList = false
    @Binding var isActive:Bool
    @Environment(\.dismiss) var dismiss
    let arr = [
        Favorite(keyWord: FavoriteFilter.bus.title, city: "대전광역시", location: "갤러리아백화점", lat: 36.35197893239247, long: 127.37835811586957, title: "우리 백화점", image: FavoriteFilter.bus.imageName),
        Favorite(keyWord: FavoriteFilter.bus.title, city: "대전광역시", location: "갤러리아백화점", lat: 36.35197893239247, long: 127.37835811586957, title: "우리 백화점", image: FavoriteFilter.bus.imageName),
        Favorite(keyWord: FavoriteFilter.bus.title, city: "대전광역시", location: "갤러리아백화점", lat: 36.35197893239247, long: 127.37835811586957, title: "우리 백화점", image: FavoriteFilter.bus.imageName),
        Favorite(keyWord: FavoriteFilter.bus.title, city: "대전광역시", location: "갤러리아백화점", lat: 36.35197893239247, long: 127.37835811586957, title: "우리 백화점", image: FavoriteFilter.bus.imageName),
        Favorite(keyWord: FavoriteFilter.bus.title, city: "대전광역시", location: "갤러리아백화점", lat: 36.35197893239247, long: 127.37835811586957, title: "우리 백화점", image: FavoriteFilter.bus.imageName)
    ]
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                
                Map(coordinateRegion: $region,showsUserLocation: true,annotationItems:arr){ item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Circle().overlay{
                            Image(systemName: item.image)
                        }
                    }
                }
                    .ignoresSafeArea()
                
                HeaderView(title: "즐겨 찾기").frame(maxHeight: .infinity,alignment: .top)
                   
                
                
                header
                VStack(spacing:0){
                caseCategory.frame(maxHeight: .infinity,alignment: .bottom)
//                    if !showList,!vmFav.favoritList.isEmpty{
//                        List{
//                            ForEach(arr) { item in
//                                FavoriteListRowView(favorite: item).environmentObject(vmFav)
//                            }
//                            .listRowBackground(Color.clear)
//                        }.listStyle(.plain).frame(height: 250)
//                            .background {
//                                Color.black.opacity(0.5)
//                            }.cornerRadius(10).padding(5)
//                    }
                    List{
                        ForEach(arr) { item in
                            FavoriteListRowView(favorite: item).environmentObject(vmFav)
                        }
                        .listRowBackground(Color.clear)
                    }.listStyle(.plain).frame(height: 250)
                        .background {
                            Color.black.opacity(0.5)
                        }.cornerRadius(10).padding(5)
                }
                
                
                
            }.onReceive(vm.regionSuccess) {
                DispatchQueue.main.async {
                    region = MKCoordinateRegion(center:vm.mapCoordinate, span: vm.mySpan)
                }
            }
            .onAppear{
                vmFav.favoriteResponse(keyWord: favoriteFilter.title)
                print(favoriteFilter.title)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
        
        
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(isActive: .constant(true))
    }
}

extension FavoriteView{
    var caseCategory:some View{
        HStack{
            if !tapCategory{
                filter(image: favoriteFilter.imageName, title: favoriteFilter.title)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            withAnimation(.linear){
                                tapCategory = true
                            }
                        }
                    }
                Button {
                    DispatchQueue.main.async {
                        withAnimation(.spring()){
                            showList.toggle()
                        }
                    }
                    
                } label: {
                    if !showList,!vmFav.favoritList.isEmpty{
                        Image(systemName: showList ? "chevron.up": "chevron.down").foregroundColor(.primary.opacity(0.5))
                            .font(.title).bold()
                    }
                    
                }
            }else{
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(FavoriteFilter.allCases,id: \.self) { item in
                            filter(image:item.imageName , title: item.title)
                                .onTapGesture {
                                    favoriteFilter = item
                                    vmFav.favoriteResponse(keyWord: item.title)
                                    print(favoriteFilter.title)
                                    tapCategory = false
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        
    }
    var header:some View{
        HStack(spacing: 20){
            Button {
                dismiss()
            } label: {
                Image(systemName:"chevron.left")
            }.padding(.leading)
            Spacer()
            Button {
                isActive = true
            } label: {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 30,height:30)
            }
        }.bold().foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topTrailing).padding(.trailing)
            .offset(y:5)
            .navigationDestination(isPresented: $isActive) {
                LocationSelectView(postMod: .constant(false),isActive: $isActive)
            }
    }
    func filter(image:String,title:String)->some View{
        VStack(spacing:0){
            Image(systemName: image)
                .resizable()
                .frame(width: 20,height: 20)
                .padding(10)
            Text(title).font(.caption).bold()
        }
        .padding(10)
        .foregroundColor(.white)
        .background {
            Color.black.opacity(0.5).clipShape(Circle())
        }
        .padding(.leading,5)
    }
}
