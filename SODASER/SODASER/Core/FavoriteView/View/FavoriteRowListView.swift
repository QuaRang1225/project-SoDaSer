//
//  FavoriteListView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/02/22.
//

import SwiftUI

struct FavoriteListRowView: View {
    let favorite:Favorite?
    @EnvironmentObject var vmFav:FavoriteViewModel
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: favorite?.image ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 10,height: 10)
                    .padding(5)
                    .background(Color.black.opacity(0.5).clipShape(Circle()))
                Text(favorite?.title ?? "").font(.callout).bold().padding(2)
            }
            HStack(alignment: .bottom){
                Text(favorite?.city ?? "").bold().font(.callout)
                Spacer()
                Text(favorite?.location ?? "").font(.caption)
            }
            Divider().background(.white)
        }.foregroundColor(.white)
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        
        FavoriteListRowView(favorite: CustomPreView.instance.favorite)
            .background(Color.black.opacity(0.5))
            .environmentObject(FavoriteViewModel())
    }
}

