//
//  CourseView.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//
//modiferByweiwenyue
//modifedByWzt

import SwiftUI

struct CourseView: View {
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                Banner()
                CourseInfo()
                
                CourseIntro()

                RelatedCourses()
            
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
