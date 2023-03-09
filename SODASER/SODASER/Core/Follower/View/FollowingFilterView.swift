//
//  FollowingFilterView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/02.
//

import SwiftUI

struct FollowingFilterView: View {
    
    @Namespace var animation
    let user:UserData
    @State var followFilter:FollowFilter
    @EnvironmentObject var vmFollow:FollowerViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            VStack{
                ZStack{
                    Text(user.nickname).font(.title2).bold()
                    HStack{
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left").bold()
                        }
                        Spacer()
                    }
                    .padding()
                }.foregroundColor(.blackIndigo)
                filterView
            }.background(Color.whiteCyan)
            modeView
        }.background(Color.white.ignoresSafeArea())
        .onAppear{
            vmFollow.getFollowerList(email: user.email)
            vmFollow.getFollowingList(email: user.email)
        }
    }
}

struct FollowingFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingFilterView(user: CustomPreView.instance.user, followFilter: .follower)
            .environmentObject(FollowerViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}

extension FollowingFilterView{
    var modeView:some View{
        VStack{
            switch followFilter{
            case .follower:
                FollowerView(filter: .follower, list: vmFollow.followerList, user: user).environmentObject(vmFollow)
                    .environmentObject(vmAuth)
                    .onAppear{
                        vmFollow.getFollowerList(email: user.email)
                    }
            case .following:
                FollowerView(filter: .following, list: vmFollow.followingList, user: user).environmentObject(vmFollow)
                    .environmentObject(vmAuth)
                    .onAppear{
                        vmFollow.getFollowingList(email: user.email)
                    }
            }
        }
    }
    var filterView:some View{
        HStack{
            //TweetFilterViewModel.allCases - 모든 케이스 범위
            ForEach(FollowFilter.allCases,id: \.self){ item in
                VStack{
                    Text(item.mode)
                        .font(.callout)
                        .fontWeight(followFilter == item ? .semibold: .regular)
                        //.foregroundColor(vmFilter == item ? .primary : .primary.opacity(0.7))
                        .padding(.bottom,5)
                        .shadow(radius: 10)
                    
                    if followFilter == item{
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
                        colors: [ followFilter == item ? .cyan.opacity(0.8) : .gray.opacity(0.5),followFilter == item ? .blue.opacity(0.8) : .gray.opacity(0.5)],
                    startPoint: .leading,
                    endPoint: .trailing))
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.followFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(y:17.5))
        
    }
}
