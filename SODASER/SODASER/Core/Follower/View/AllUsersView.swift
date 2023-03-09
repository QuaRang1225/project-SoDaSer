//
//  AllUsersView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/03.
//

import SwiftUI
import Combine

struct AllUsersView: View {
    let user:UserData
    @State var text = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vmFollow:FollowerViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack{
                HeaderView(title: "전체 유저 검색")
                    .overlay{
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left").font(.title2).bold()
                                    .foregroundColor(.white).padding()
                            }
                            Spacer()
                        }
                    }
                CustomInputView(imageName: "magnifyingglass", placeholderText: "전체 검색 ..", imageColor: .blackIndigo, text: $text)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 20)
                
                FollowerView(list: vmFollow.users.filter{$0 != user}, user: user)
            }
        }
    }
}

struct AllUsersView_Previews: PreviewProvider {
    static var previews: some View {
        AllUsersView(user: CustomPreView.instance.user).environmentObject(FollowerViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
