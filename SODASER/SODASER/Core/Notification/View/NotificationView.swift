//
//  NotificationView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/12/29.
//

import SwiftUI
import MapKit
import Kingfisher

struct NotificationView: View {
    @EnvironmentObject var vm:MainViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ZStack{
                HeaderView(title: "알림 목록").padding(.bottom,5)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading)
                }
            }
            
                
            Text("알림")
                .onTapGesture {
                    NotificationManager.instance.scheduleNotification()
                }
            List{
                ForEach(0...10,id: \.self){ _ in
                    UserListRowView(url: CustomPreView.instance.imageArr.first!, nickName: "Boring_", name: "", content: "님이 좋아요를 눌렀습니다.").listRowBackground(Color.clear)
                }
            }.listStyle(.plain)
           
            .scrollContentBackground(.hidden)
        } .background{
            ZStack{
                MapView(isView: false, mod: false)
                Color.black.opacity(0.5).ignoresSafeArea()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }.navigationBarBackButtonHidden()
    }
    func removeList(at:IndexSet){
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
