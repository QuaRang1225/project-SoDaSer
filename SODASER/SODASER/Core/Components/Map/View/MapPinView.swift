//
//  MapPinView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/12/29.
//

import SwiftUI
import Kingfisher

struct MapPinView: View {
    @EnvironmentObject var vm:AuthenticationViewModel
    let user:UserData?
    let postingImage:String?
    var body: some View {
        ZStack{
            Image(systemName: "drop.fill")
                .font(.system(size: 70))
                .rotationEffect(.degrees(180))
                .overlay {
                    if let image = postingImage{
                        KFImage(URL(string:image)!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40)
                            .clipShape(Circle())
                            .offset(y:-10)
                    }else{
                        KFImage(URL(string:user?.profileImage ?? "")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40)
                            .clipShape(Circle())
                            .offset(y:-10)
                    }
                }.offset(y:-40)
        }.shadow(color: .primary.opacity(0.2),radius: 20).foregroundColor(.whiteCyan)
            .padding()
    }
}

struct MapPinView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            //Color.blue
            MapPinView(user: CustomPreView.instance.user, postingImage: nil).environmentObject(AuthenticationViewModel())
        }
    }
}
