//
//  RelatedView.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct RelatedCourses: View {
    var body: some View{
        VStack(){
            Text("相关训练")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 10.0)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    CourseItem()
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

struct RelatedView_Previews: PreviewProvider {
    static var previews: some View {
        RelatedCourses()
    }
}
