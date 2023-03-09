//
//  PhotoView.swift
//  SODASER
//
//  Created by 유영웅 on 2023/01/13.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    
    @Binding var item:[Data]
    var body: some View {
            VStack(spacing: 15){
                TabView{
                    ForEach(item,id: \.self){ index in
                        if let image = UIImage(data:index){
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        }
                    }
                }
                .frame(width: UIScreen.photoWidth,height: UIScreen.photoWidth)
                    .shadow(radius: 10)
                    .tabViewStyle(PageTabViewStyle())
            }
    }
    
}
