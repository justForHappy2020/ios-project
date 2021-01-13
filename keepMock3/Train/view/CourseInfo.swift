//
//  CourseInfo.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct CourseInfo: View {
    var body: some View {
        HStack{
            VStack(){
                Text("燃脂")
                    .foregroundColor(boldGreyColor)
                HStack(){
                    Text("999")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("千卡")
                }
            }
            Spacer()
            VStack(){
                Text("时长")
                    .foregroundColor(boldGreyColor)
                HStack(){
                    Text("12")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("分钟")
                }
            }
            Spacer()
            VStack(){
                Text("难度")
                    .foregroundColor(boldGreyColor)
                HStack(){
                    Text("K1")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("初学")
                }
            }
        }
        .padding()
        .frame(height: 80)
    }
}

struct CourseInfo_Previews: PreviewProvider {
    static var previews: some View {
        CourseInfo()
    }
}
