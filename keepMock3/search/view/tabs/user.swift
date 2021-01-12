//
//  user.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/31.
//

import SwiftUI

struct user: View {
    var body: some View {
        VStack(){
            HStack{
                Image("shareImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60.0, height: 60.0, alignment: .center)
                    .clipShape(Circle())
                
                Text("keep_新人助手")
                
                Spacer()
                
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(boldGreenColor)
                                    .frame(width: 75, height: 30)
                                    .overlay(Text("关注").foregroundColor(.white))
                }
            }.padding(.all,20)
            
            Divider()
            
        }.frame(
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading)
        .background(bgGrey)
        .edgesIgnoringSafeArea(.all)
    }
}

struct user_Previews: PreviewProvider {
    static var previews: some View {
        user()
    }
}
