//
//  CustomInputView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct CustomInputView: View {
    let imageName:String?
    let placeholderText:String
    var securefield:Bool? = false
    let imageColor:Color
    @Binding var text:String
    
    var body: some View {
        VStack(spacing:5){
            HStack{
                if let imageName  = imageName{
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .foregroundColor(imageColor)
                        .padding(.trailing,5)
                }
                ZStack(alignment: .leading){
                    if text.isEmpty {
                        Text(" " + placeholderText).foregroundColor(.gray)
                    }
                    if securefield ?? false{
                        SecureField("", text: $text)
                            .autocapitalization(.none)//첫글자 항상 소문자로 시작
                            .textCase(.lowercase)
                    }else{
                        TextField("", text: $text)
                            .autocapitalization(.none)//첫글자 항상 소문자로 시작
                            .textCase(.lowercase)
                    }
                }.foregroundColor(imageColor)
            }
            .foregroundColor(imageColor)
//            Divider()
//                .frame(height: 1)
//                .background(Color.white)
        }.overlay(alignment:.trailing){
            xmark.offset(x:20).padding(.bottom,5)
        }//.padding()
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            CustomInputView(imageName: "envelope", placeholderText: " 이메일", imageColor: Color.white, text: .constant(""))
        }.ignoresSafeArea()
    }
}

extension CustomInputView{
    var xmark:some View{
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.blackIndigo)
            .font(.headline)
            .padding(30)
            .opacity(text.isEmpty ?  0.0 : 1.0)
            .onTapGesture {
                UIApplication.shared.endEditing()
                text = ""
                print("눌림")
            }
    }
}
