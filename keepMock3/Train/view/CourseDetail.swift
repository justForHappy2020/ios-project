//
//  courses.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/31.
//

import SwiftUI
import RemoteImage
import SlideOverCard

struct CourseDetail: View {
    @State var cid:Int
//    @State var curState: status = .hasNotCache
//    @State var canNavigation:Bool = false
//    @ObservedObject var courseDetailViewModel = CourseDetailViewModel()
    let courseDetailViewModel = CourseDetailViewModel()
    
    //动作list
    @State private var position = CardPosition.bottom
    //传入一个actionViewModel
    @ObservedObject var actionViewModel = ActionViewModel()
    
//    enum status:Int{
//        case hasCache
//        case hasNotCache
//    }
//
//    func getDestination(_ curState: status) -> AnyView {
//        switch curState {
//        case .hasCache:
//            return AnyView(VideoPlayView())
//        case .hasNotCache:
//            return AnyView(VideoCacheView(relatedId: cid))
//        }
//    }
    
    var body: some View{
        ZStack{
            VStack(){
                ScrollView {
                    banner()
                        .padding(.bottom,10)
                    courseIntro()
                    separate(height: 10)
                    courseDesc()
                    separate(height: 10)
                    relativeCourse()
                    separate(height: 10)
                    actionIntro(position: $position)
                        .padding(.bottom,20)
                    joinBtn(cid: cid)
                        .padding(.bottom,50)
                }
            }
            .environmentObject(courseDetailViewModel)
            .environmentObject(actionViewModel)
            .onAppear(perform: {
                courseDetailViewModel.fetchCourseData(cid: cid)
                courseDetailViewModel.fetchRelativeCourse(cid: cid)
            })
            .frame(
                minWidth: 0, maxWidth: .infinity,
                alignment: .topLeading)
            .background(bgGrey)
            .edgesIgnoringSafeArea(.all)
            
            
            ActionView(position: $position, actionViewModel: actionViewModel,showStartBtn:true,cid: cid)
                .onAppear(){
                    //当打开的时候就去获取信息
                    actionViewModel.fetchActionDataBycid()
                }
        }
    }
    
    struct banner: View{
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        
        var body: some View{
            ZStack(){
                if URL(string:courseDetailViewModel.course.backgroundUrl) != nil{
                    RemoteImage(type: .url(URL(string:courseDetailViewModel.course.backgroundUrl)!), errorView: { error in
                        Text(error.localizedDescription)
                    }, imageView: { image in
                        image
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight:200)
                    }, loadingView: {
                        Text("Loading ...")
                    })
                    VStack(){
                        Text(courseDetailViewModel.course.courseName)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            }.frame(width:.infinity)
        }
    }

    struct courseIntro:View{
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        
        var threeColumnGrid: [GridItem] = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
        var body: some View{
             LazyVGrid(columns: threeColumnGrid) {
                
                    VStack(){
                        Text("燃脂")
                            .foregroundColor(boldGreyColor)
                        HStack(){
                            Text(courseDetailViewModel.course.calorie.description)
                                .font(.title)
                                .fontWeight(.bold)

                            Text("千卡")
                        }
                    }
                    
                    VStack(){
                        Text("时长")
                            .foregroundColor(boldGreyColor)
                        HStack(){
                            Text(courseDetailViewModel.course.duration.components(separatedBy: ":")[0])
                                .font(.title)
                                .fontWeight(.bold)
                            Text("分钟")
                        }
                    }
                    
                    VStack(){
                        Text("难度")
                            .foregroundColor(boldGreyColor)
                        HStack(){
                            Text(courseDetailViewModel.course.degree)
                                .font(.title)
                                .fontWeight(.bold)
                            Text("初学")
                        }
                    }
             }
        }
    }

    struct courseDesc: View{
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        
        var body: some View{
            VStack(){
                Text("课程介绍")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 10.0)

                Text(courseDetailViewModel.course.courseIntro)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
        }
    }

    struct relativeCourse:View{
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        
        var body: some View{
            VStack(){
                Text("相关训练")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 10.0)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(courseDetailViewModel.relativeCourse,id:\.courseId) { course in
                            relatedCourseItem(width: 168, height: 114, hasRound: false, course: course)
                        }
                    }
                }
            }
            .padding()
        }
    }

    struct actionIntro:View{
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        @Binding var position : CardPosition
        
        var body: some View{
            VStack{
                HStack{
                    Text("课程内容")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 10.0)
                    Spacer()
                    Text("\(courseDetailViewModel.course.actionList.count)个动作")
                }.padding()
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
//                        ForEach(courseDetailViewModel.course.actionList,id:\.actionId) { action in
//                            actionIntroItem(action: action, position: $position)
//                        }
//                        ForEach(courseDetailViewModel.course.actionList.indices) { index in
//                            actionIntroItem(action: courseDetailViewModel.course.actionList[index], position: $position,idx:index)
//                        }
                        ForEach(Array(courseDetailViewModel.course.actionList.enumerated()),id:\.1.actionId) { (index,action) in
                            actionIntroItem(action: action, position: $position,idx:index)
                        }
                    }
                }.padding(.horizontal, 10.0)
                
            }
        }
    }

    struct actionIntroItem:View{
        @State var action: Action
        @Binding var position:CardPosition
        @State var idx:Int
        @EnvironmentObject var actionViewModel:ActionViewModel
        
        var body: some View{
            ZStack{
                RemoteImage(type: .url(URL(string:action.actionImgs)!), errorView: { error in
                    Text(error.localizedDescription)
                }, imageView: { image in
                    image
                    .resizable()
                    .frame(width: 168, height: 114)
                }, loadingView: {
                    Text("Loading ...")
                        .foregroundColor(.white)
                        .frame(width: 168, height: 114)
                        .background(lightGreyColor)
                })
                
                VStack(){
                    Spacer()
                    HStack(){
                        Text(action.actionName)
                            .foregroundColor(.white)
                        Spacer()
                        Text(action.intro)
                            .foregroundColor(.white)
                    }
                }.frame(width: 168, height: 114)
            }
            .frame(width: 168, height: 114)
            .onTapGesture {
                //当点击的时候将对应的actionId传入actionModel里面
                self.position = CardPosition.top
                actionViewModel.curIdx = idx
            }
        }
    }

    struct separate: View{
        @State var height: CGFloat
        var body: some View{
            Rectangle()
                .fill(lightGreyColor)
                .frame(height: height)
        }
    }

    struct joinBtn: View{
        
        enum status:Int{
            case hasCache
            case hasNotCache
        }
        
        func getDestination(_ curState: status) -> AnyView {
            switch curState {
            case .hasCache:
                return AnyView(VideoPlayView(relatedId: cid))
            case .hasNotCache:
                return AnyView(VideoCacheView(relatedId: cid))
            }
        }
        
        @State var curState: status = .hasNotCache
        @State var canNavigation:Bool = false
        @State var cid: Int
        @EnvironmentObject var courseDetailViewModel: CourseDetailViewModel
        var body: some View{
            NavigationLink(
                destination: getDestination(self.curState).navigationBarHidden(true).navigationBarTitle(""),
                isActive:$canNavigation) {
                Text("参加课程")
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .frame(maxWidth:.infinity)
                    .background(boldGreenColor)
                    .foregroundColor(.white)
                    .padding(.bottom,20)
                    .onTapGesture {
                        if(courseDetailViewModel.IsVideoCacheExists(cid: cid)){
                            self.curState = .hasCache
                        }
                        self.canNavigation = true
                    }
            }
        }
    }
}

struct courses_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(cid: 2)
    }
}
