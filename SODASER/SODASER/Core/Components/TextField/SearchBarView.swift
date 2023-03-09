//
//  SearchBarView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/17.
//

import SwiftUI
import Kingfisher

struct SearchBarView: View {
    
    
    
    @Binding var isActive:Bool
    @Binding var text:String
    @EnvironmentObject var vm:AuthenticationViewModel
    
    var body: some View {
       
            VStack{
                HStack(spacing:0){
                    Image("WhiteSoda")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .padding(.leading,5)
                    Text(vm.user?.nickname ?? CustomPreView.instance.user.nickname)
                        .bold()
                        .font(.title2)
                        
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        self.isActive = true
                    } label: {
                        Image(systemName: "plus.app.fill").font(.system(size: 30)).padding(.trailing,10).foregroundColor(.white)
                    }
                    .navigationDestination(isPresented: $isActive){
                        LocationSelectView(postMod: .constant(true), isActive: $isActive)
                    }
                }
                CustomInputView(imageName: "magnifyingglass", placeholderText: "검색..", imageColor: .white, text: $text).padding()
                
                
            }.navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.blue
            SearchBarView(isActive: .constant(true), text: .constant("")).environmentObject(AuthenticationViewModel())
        }
        
    }
}

