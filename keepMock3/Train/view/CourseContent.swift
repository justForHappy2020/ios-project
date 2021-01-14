//
//  CourseContent.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct CourseContent: View {
    var body: some View {
        VStack{
            HStack{
                Text("课程内容")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 10.0)
                Spacer()
                Text("5个动作")
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    CourseItem()
                    CourseItem()
                    CourseItem()
                    CourseItem()
                    CourseItem()
                }
            }
        }
        .padding()
    }
}

struct CourseContent_Previews: PreviewProvider {
    static var previews: some View {
        CourseContent()
    }
}
