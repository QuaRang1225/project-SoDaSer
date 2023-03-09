//
//  ProfileGridView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/10.
//

import SwiftUI
import Kingfisher
import MapKit

struct ProfileGridView: View {
    
    let user:UserData
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 20,
                pinnedViews: [],
                content: {
                    ForEach(vmPost.post){ item in
                        NavigationLink {
                            PostView(post: item, user: user, region: MKCoordinateRegion(center: item.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
                                .environmentObject(vmPost)
                        } label: {
                            if let savedImage = LocalFileManager.instance.getImage(imageName:String(describing: item.id), folderName: vmPost.imageFolderName){
                                Image(uiImage: savedImage)
                                    .resizable()
                                    .frame(height: UIScreen.photoWidth/3.5)
                                    .clipped()
                                    .cornerRadius(20)
                            }else{
                                KFImage(URL(string: item.image))
                                    .resizable()
                                    .frame(height: UIScreen.photoWidth/3.5)
                                    .clipped()
                                    .cornerRadius(20)
                            }
                            
                        }.padding(.horizontal,5)
                    }
                }).padding(20).shadow(radius: 10)
        }.refreshable {
            if vmAuth.user == user{
                vmPost.postList(email: "")
            }else{
                vmPost.postList(email: user.email)
            }
        }.onAppear{
            if vmAuth.user == user{
                vmPost.postList(email: "")
            }else{
                vmPost.postList(email: user.email)
            }
        }.environmentObject(vmAuth)
    }
}

struct ProfileGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileGridView(user: CustomPreView.instance.user).environmentObject(PostViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
