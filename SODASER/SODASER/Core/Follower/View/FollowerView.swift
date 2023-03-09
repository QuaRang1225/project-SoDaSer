//
//  FollowerView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/12/28.
//

import SwiftUI
import MapKit
import Kingfisher

struct FollowerView: View {

    @State var filter:FollowFilter?
    @State var list:[UserData]
    let user:UserData
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    @EnvironmentObject var vmFollow:FollowerViewModel
    var body: some View {
                List{
                    ForEach(list,id: \.self){ item in
                        
                        NavigationLink {
                            ProfileView(user: item,logOut: .constant(true))
                        } label: {
                            if let profileImage = item.profileImage{
                                UserListRowView(url: profileImage, nickName:  item.nickname, name: item.name, content: "")
                            }else{
                                HStack{
                                    DummyCircle(width: 50, height: 50)
                                    VStack(alignment: .leading,spacing: 5){
                                        Text(item.nickname)
                                        Text(item.name)
                                    }.foregroundColor(.blackIndigo)
                                }
                            }
                        }.listRowBackground(Color.clear)
                    }
                }.listStyle(.plain)
                .scrollContentBackground(.hidden)
            .navigationBarBackButtonHidden()
            .environmentObject(vmFollow)
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView(filter: .follower, list: [CustomPreView.instance.user], user: CustomPreView.instance.user)
            .environmentObject(AuthenticationViewModel())
            .environmentObject(FollowerViewModel())
    }
}


//if item == vmAuth.user{
//    Button {
//        myProfile = false
//        //dismiss()
//        //print(myProfile)
//    } label: {
//        if let profileImage = item.profileImage{
//            UserListRowView(url: profileImage, nickName:  item.nickname, name: item.name, content: "")
//        }else{
//            HStack{
//                DummyCircle(width: 50, height: 50)
//                VStack(alignment: .leading,spacing: 5){
//                    Text(item.nickname)
//                    Text(item.name)
//                }.foregroundColor(.blackIndigo)
//            }
//        }
//    }.listRowBackground(Color.clear)
//
//}else{
//    NavigationLink {
//        ProfileView(email: item.email,logOut: .constant(true))
//    } label: {
//        if let profileImage = item.profileImage{
//            UserListRowView(url: profileImage, nickName:  item.nickname, name: item.name, content: "")
//        }else{
//            HStack{
//                DummyCircle(width: 50, height: 50)
//                VStack(alignment: .leading,spacing: 5){
//                    Text(item.nickname)
//                    Text(item.name)
//                }.foregroundColor(.blackIndigo)
//            }
//        }
//    }.listRowBackground(Color.clear)
//}
