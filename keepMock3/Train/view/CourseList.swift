//
//  CourseList.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/18.
//

import SwiftUI
import SwiftUIRefresh

struct CourseList: View{
    
    let courses: [CourseNotAction] //一个要显示的存储库数组
    let isLoading: Bool // 一个isLoading标志，该标志指示是否需要显示加载动画。
    let onScrolledAtBottom: () -> Void  //一个回调通知该列表何时滚动到底
    
    var body: some View {
        LazyVStack{
            courList
            if isLoading{
                loadingIndicator
            }
            if !isLoading{
                noMoreInfo
            }
        }
        .padding(.all,10)
    }

    private var courList: some View{
        ForEach(courses,id:\.courseId) { courItem in
            CourseViwe(course: courItem)
                .fixedSize(horizontal: false, vertical: true)
                .onAppear {
                if self.courses.last == courItem {
                    self.onScrolledAtBottom()
                }
            }
        }
    }
    
    private var loadingIndicator: some View{
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
    
    private var noMoreInfo: some View{
        Text("没有更多🔝")
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct CourseViwe:  View{
    @State var course: CourseNotAction
    
    var body: some View{
        NavigationLink(destination: CourseDetail(cid:course.courseId)) {
            VStack(alignment: .trailing){
                
                Text(course.courseName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(course.duration)分钟    \(course.degree)")
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .fixedSize()
            .padding(.all,10)
            .frame(idealWidth: .infinity, maxWidth: .infinity, idealHeight: 150, maxHeight: 150,alignment: .bottomLeading)
            .background(
                Image("shareImage")
                    .resizable()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, idealHeight: 150, maxHeight: 150,alignment: .center)
            )
        }
    }
}

