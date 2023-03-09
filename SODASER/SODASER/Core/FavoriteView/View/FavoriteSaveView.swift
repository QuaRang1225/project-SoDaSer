//
//  FavoriteSaveView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import SwiftUI
import MapKit

struct FavoriteSaveView: View {
    
    @State var text = ""
    @State var region = MKCoordinateRegion()
    @State var favoriteFilter:FavoriteFilter = .food
    @Binding var isActive:Bool
    
    @State var coordinate:CLLocationCoordinate2D
    @State var city:String
    @State var location:String
    
    @State var tapCategory = false
    @State var showList = false
    @StateObject var vmFav = FavoriteViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top){
            Map(coordinateRegion: $region).ignoresSafeArea()
            Color.black.opacity(0.5).ignoresSafeArea()
            Text("위치저장").font(.title2).bold()
            VStack(alignment: .leading,spacing: 5){
                
                HStack{
                    Button {
                        //isActive = false
                        dismiss()
                    } label: {
                        Image(systemName:"chevron.left")
                            .padding(.top)
                            .padding(.leading)
                    }
                    Spacer()
                    Button {
                        vmFav.favorite(keyWord: favoriteFilter.title, city: city, location: location, lat: coordinate.latitude, long: coordinate.longitude, title: text, image: favoriteFilter.imageName)
                    } label: {
                        Text("저장")
                            .padding(.top)
                            .padding(.trailing)
                            .bold()
                    }
                }
                caseCategory
                CustomInputView(imageName: "pencil", placeholderText: "제목 ..", imageColor: .white, text: $text).padding()
                Group{
                    Text(city).font(.title3)
                    Text(location).font(.caption)
                }.padding(.leading).bold()
                
                Spacer()
            }
            
        }.foregroundColor(.white)
        .onAppear{
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
    }
}

struct FavoriteSaveView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSaveView(isActive: .constant(true), coordinate: CLLocationCoordinate2D(), city: "대전광역시", location: "가수원역").environmentObject(MapViewModel())
    }
}
extension FavoriteSaveView{
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
            }else{
                ScrollView(.horizontal) {
                    HStack(spacing:0){
                        ForEach(FavoriteFilter.allCases,id: \.self) { item in
                            filter(image: item.imageName, title: item.title)
                            .onTapGesture {
                                favoriteFilter = item
                                tapCategory = false
                            }
                        }
                    }
                }
            }
            Spacer()
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
        .padding()
    }
}
