//
//  UserListRowView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/15.
//

import SwiftUI
import Kingfisher

struct UserListRowView: View {
    
    let url:String
    let nickName:String
    let name:String
    let content:String
    
    var body: some View {
        HStack{
            KFImage(URL(string: url))
                .resizable()
                .modifier(CustiomModifier(width: 50, height: 50, radius: 0))
                .clipShape(Circle())
            VStack(alignment: .leading,spacing: 5){
                Text(nickName).bold()
                if !name.isEmpty{
                    Text(name)
                }
            }.foregroundColor(.blackIndigo)
            Text(content)
            Spacer()
        }.foregroundColor(.blackIndigo)
        
    }
}

struct UserListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.pink.opacity(0.3)
            UserListRowView(url:CustomPreView.instance.imageArr.first!, nickName: "Boring_" , name: "이도훈", content: "님이 좋아요를 눌렀습니다.")
        }
        
    }
}
