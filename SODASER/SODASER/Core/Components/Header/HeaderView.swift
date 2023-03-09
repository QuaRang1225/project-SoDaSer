//
//  HeaderView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/15.
//

import SwiftUI

struct HeaderView: View {
    let title:String
    var body:some View{
        VStack{
            ZStack{
                Text(title).bold().frame(maxWidth: .infinity,alignment: .center)
            }
            .font(.title3)
            .foregroundColor(.white)
            .padding(.top,10)
            .background{
                Color.black.opacity(0.5).frame(height: 100).ignoresSafeArea()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "위치검색")
    }
}
