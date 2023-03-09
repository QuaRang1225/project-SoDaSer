//
//  ContentView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/09/30.
//

import SwiftUI

struct StartView: View {
    
    @State var animate:Bool = false
    @State var isLoading:Bool = false
    
    var body: some View {
        ZStack{
            Color.whiteCyan.ignoresSafeArea()
            Image("map")
                .resizable()
                .scaledToFill()
                .frame(width: 300,height: 300).clipShape(Circle())
                .padding(.leading,300)
                .shadow(radius: 20)
            VStack(alignment: .trailing,spacing: 0){
                Image("title")
                    .resizable()
                    .frame(width: 250,height: 100).offset(x:20)
                    .opacity(animate ? 1.0:0.0)
                    .offset(x:animate ? 0:100)
                Image("subtitle")
                    .resizable()
                    .frame(width: 350,height: 50)
                    .opacity(animate ? 1.0:0.0)
                    .offset(x:animate ? 0:-100)
                
            }.padding(.top,100).shadow(radius: 20)
            
            VStack{
                Spacer().frame(height: 600)
                ZStack(alignment: .top){
                    Color.brown.ignoresSafeArea()
                    HStack{
                        ForEach(0...100,id: \.self){ index in
                            Image(systemName: "line.diagonal").padding(5).rotationEffect(Angle(degrees: index%2 == 0 ?  30 : 60)).foregroundColor(.black)
                        }
                    }
                    
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 50,height: 100)
                        .foregroundColor(.red)
                        .offset(y:-5)
                        .padding(.leading,200)
                    Image("pencil")
                        .resizable()
                        .frame(width: 200,height: 200)
                        .padding(.trailing,200)
                        .frame(maxHeight: .infinity,alignment:.bottom)
                        .shadow(radius:0.4)
                        .ignoresSafeArea()
                    
                }
                
            }
            .onAppear{
                animateLogoOn()
                animateLogoOff()
            }
        }
    }
    func animateLogoOn(){
        DispatchQueue.main.async {
            withAnimation(.easeIn(duration: 0.5)){
                self.animate.toggle()
            }
        }
    }
    func animateLogoOff(){
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0){
            withAnimation(.easeIn(duration: 0.5)){
                self.animate.toggle()
                
            }
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
