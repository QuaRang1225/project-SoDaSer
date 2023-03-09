//
//  SelectionBarView.swift
//  SODASER
//
//  Created by 유영웅 on 2022/10/18.
//

import SwiftUI
import Kingfisher

struct SelectionBarView: View {
    //@State var isActive = false
    @State var selsctActive = false
    @State var isPicked = false
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vmFollow = FollowerViewModel()
    @EnvironmentObject var vmPost:PostViewModel
    @EnvironmentObject var vmAuth:AuthenticationViewModel
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.whiteGray)
        
        
        let itemAppearance = UITabBarItemAppearance(style: .stacked)
        itemAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance = itemAppearance
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .bottom){
                
                TabView{
                    Group {
                        MainView(user: vmAuth.user ?? CustomPreView.instance.user)
                            .tabItem {
                                Image(systemName: "house.fill")
                            }.environmentObject(vmFollow)
                        Text("")
                        
                            .tabItem {
                                Image(systemName: "star.fill")
                            }
                    }
                    
                }.accentColor(.white)
                
                NavigationLink {
                    
                } label: {
                        
                        
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 50,height: 50)
                            .bold()
                            .padding(.bottom,50)
                            .frame(width: 150,height: 90)
                    
                        .shadow(radius: 3)
                        .foregroundColor(.white)
                        .offset(y:20)
                        .background{
                            Group{
                                Rectangle()
                                    .foregroundColor(.white)
                                    
                                Rectangle()
                                    .foregroundColor(.cyan.opacity(0.3))
                            }.ignoresSafeArea()
                                .clipShape(RoundedShape(corners: [.topLeft,.topRight], width: 20, height: 20))
                                .frame(width: 150,height: 90)
                                .shadow(radius: 2)
                        }
                        
                }
                
            }.ignoresSafeArea()
            
        }
    }
}

struct SelectionBarView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBarView()
            .environmentObject(PostViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
