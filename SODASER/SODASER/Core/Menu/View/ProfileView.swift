//
//  ProfileView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/18.
//

import SwiftUI
import MapKit
import Kingfisher

struct ProfileView: View {
    
    //let user:UserData?
    let user:UserData
    //let selfProfile:Bool
    @State var isFollow = false
    @Namespace var animation //matchedGeometryEffect을 사용하기 위한 속성
    @State var vmFilter:PostFilter = .photo
    @State var myProfile = false
    @Binding var logOut:Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    @StateObject var vmFollow = FollowerViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                // if let user = vmFollow.user{
                
                VStack(spacing: 0){
                    ZStack{
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .font(.title3)
                                    .bold()
                            }
                            Spacer()
                            if vmAuth.user == user{
                                NavigationLink{
                                    MenuView(user: user, logOut: $logOut)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Image(systemName: "line.3.horizontal").font(.title)
                                }
                            }
                        }.padding().padding(.bottom,5)
                        
                    }
                    if let profileImage = user.profileImage{
                        KFImage(URL(string:profileImage))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 80,height: 80)
                    }else{
                        DummyCircle(width: 80, height: 80)
                    }
                    VStack(spacing: 5) {
                        HStack{
                            Text(user.nickname).font(.title2)
                            Text(user.name).font(.caption).offset(y:3)
                        }.bold()
                        Text(verbatim: user.email).font(.caption)
                    }.padding()
                    
                    follow(user: user)
                    
                    HStack{
                        if vmAuth.user != user{
                            Button {
                                vmFollow.following(targetUser: user.email)
                            } label: {
                                if (vmFollow.myfollow.firstIndex(where: {$0.email == user.email}) != nil){
                                    Text(isFollow ? "팔로우" : "팔로우 취소")
                                        .padding(5)
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                        .background(isFollow ? Color.blackIndigo: Color.gray)
                                        .cornerRadius(10)
                                        .padding(10)
                                    
                                }else{
                                    Text(isFollow ? "팔로우 취소":"팔로우")
                                        .padding(5)
                                        .padding(.horizontal)
                                        .foregroundColor(.white)
                                        .background(isFollow ? Color.gray: Color.blackIndigo)
                                        .cornerRadius(10)
                                        .padding(10)
                                }
                            }.onReceive(vmFollow.followSuccess) { value in
                                isFollow = value
                            }
                        }
                    }
                    filterView
                    postView
                    
                }
                .foregroundColor(.blackIndigo)
                .background{
                    ZStack{
                        Color.white
                    }.ignoresSafeArea()
                }
            }
        }
        .onAppear{
            vmFollow.getMyFollowingList(email: "")
            vmFollow.otherUser(email: user.email)
            vmFollow.getFollowerList(email: user.email)
            vmFollow.getFollowingList(email: user.email)
            vmPost.postList(email: user.email)
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: CustomPreView.instance.user, logOut: .constant(true))
            .environmentObject(FollowerViewModel())
            .environmentObject(PostViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}

extension ProfileView{
    var postView:some View{
        
        
        ZStack{
            switch vmFilter{
            case .photo:
                if vmPost.post.isEmpty{
                    ScrollView{
                    }.frame(maxWidth:.infinity, alignment: .center)
                        .background(content: {
                            VStack(spacing:0){
                                Image(systemName: "exclamationmark.circle.fill").font(.system(size: 100))
                                Text("게시물 없음")
                                    .bold()
                                    .font(.title)
                                    .padding()
                            }.foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing))
                        })
                    .refreshable {
                        if vmAuth.user == user{
                            vmPost.postList(email: "")
                        }else{
                            vmPost.postList(email: user.email)
                        }
                    }
                }else{
                    ProfileGridView(user:user).environmentObject(vmPost)
                }
                
            case .map:
                PostMapView(user: user)
                    .environmentObject(vmPost)
                
            }
        }
    }
    var filterView:some View{
        HStack{
            //TweetFilterViewModel.allCases - 모든 케이스 범위
            ForEach(PostFilter.allCases,id: \.self){ item in
                VStack{
                    Image(systemName: item.titile)
                        .font(.title3)
                        .fontWeight(vmFilter == item ? .semibold: .regular)
                    //.foregroundColor(vmFilter == item ? .primary : .primary.opacity(0.7))
                        .padding(.bottom,5)
                        .shadow(radius: 10)
                    
                    if vmFilter == item{
                        Capsule()
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                        //좀더 부드러운 페이드인/아웃을 위한 메서드 id: 메뉴 고유아이디 in: namespace
                    }
                    else{
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .foregroundStyle(
                    LinearGradient(
                        colors: [ vmFilter == item ? .cyan.opacity(0.4) : .gray.opacity(0.5),vmFilter == item ? .blue.opacity(0.4) : .gray.opacity(0.5)],
                        startPoint: .leading,
                        endPoint: .trailing))
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.vmFilter = item
                    }
                }
            }.padding(.horizontal,30)
        }.padding(.top)
        //.overlay(Divider().offset(y:17.5))
        
    }
    func follow(user:UserData) -> some View{
        HStack{
            Spacer()
            Group{
                VStack{
                    Text("\(vmPost.post.count)").bold()
                    Text("게시물").font(.caption)
                }
                NavigationLink {
                    FollowingFilterView(user: user, followFilter: .follower).environmentObject(vmFollow)
                        .environmentObject(vmAuth)
                } label: {
                    VStack{
                        Text(isFollow ? "\(vmFollow.followerList.count + 1)" : "\(vmFollow.followerList.count)").bold()
                        Text("팔로워").font(.caption)
                    }
                }
                NavigationLink {
                    FollowingFilterView(user: user, followFilter: .following).environmentObject(vmFollow)
                        .environmentObject(vmAuth)
                } label: {
                    VStack{
                        Text("\(vmFollow.followingList.count)").bold()
                        Text("팔로잉").font(.caption)
                    }
                }
                
                
            }.padding(.horizontal,30)
            Spacer()
        }
    }
}

