//
//  CourseIntro.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct CourseIntro: View {
    var body: some View{
        VStack(){
            Text("课程介绍")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 10.0)
            
            Text("课程简介")
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
    }
}

struct CourseIntro_Previews: PreviewProvider {
    static var previews: some View {
        CourseIntro()
    }
}
