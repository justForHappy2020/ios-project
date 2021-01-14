//
//  CourseView.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//
// 这只是一个静态页面，还要添加NavigationLink返回到上一层的，同时用户上拉时，最好有标题

import SwiftUI

struct CourseView: View {
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                Banner()
                CourseInfo()
                Divider()
                CourseIntro()
                Divider()
                RelatedCourses()
                Divider()
                CourseContent()
                JoinBtn{
                    print("click")
                }
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CourseView()
                .previewDevice("iPhone 8")
            CourseView()
                .previewDevice("iPhone X")
        }
        
    }
}
