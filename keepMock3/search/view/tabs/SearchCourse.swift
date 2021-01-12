//
//  course.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/31.
//

import SwiftUI

struct SearchCourse: View {
    @ObservedObject var viewModel: CourseViewModel = CourseViewModel()
    @State var searchText:String
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView {
                VStack(){
//                    CourseList(courses: viewModel.state.courses, isLoading: viewModel.state.canLoadNextPage, onScrolledAtBottom: viewModel.fetchNextPageIfPossible)
                }.onAppear(perform: {
                    viewModel.searchText = searchText
                    viewModel.dataSource = dataUrl.searchUrl
                    viewModel.fetchNextPageIfPossible()
                })
            }
        }.frame(
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading)
        .padding(.all,20)
        .edgesIgnoringSafeArea(.all)
    }
}
