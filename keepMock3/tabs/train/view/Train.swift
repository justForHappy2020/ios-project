//
//  train.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/30.
//

import SwiftUI
import RemoteImage
//import SwiftUILib_WrapStack


struct navItem: Identifiable{
    let id = UUID()
    var tagId:Int
    var imgId:Int
    var name:String
}
struct Train: View {
    @ObservedObject var courseDetailViewModel = CourseDetailViewModel()
    
//    var navItems : [filterDetail] = [
//        filterDetail(tagId: 1, name: "腹部"),
//        filterDetail(tagId: 2, name: "腿部"),
//        filterDetail(tagId: 3, name: "腰部"),
//        filterDetail(tagId: 4, name: "背部"),
//        filterDetail(tagId: 5, name: "胸部"),
//        filterDetail(tagId: 6, name: "手臂"),
//        filterDetail(tagId: 7, name: "肩部"),
////        filterDetail(tagId: 8, name: "臀部")
//    ]
    
    var navItems: [navItem] = [
        navItem(tagId: 3, imgId: 1, name: "腹部"),
        navItem(tagId: 2, imgId: 2, name: "腿部"),
        navItem(tagId: 1, imgId: 3, name: "腰部"),
        navItem(tagId: 4, imgId: 4, name: "背部"),
        navItem(tagId: 8, imgId: 6, name: "手臂"),
        navItem(tagId: 6, imgId: 7, name: "肩部"),
        navItem(tagId: 9, imgId: 8, name: "臀部"),
    ]
    
    var body: some View {
        ZStack(){
            bgGrey
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                navBar()
                VStack{
                    
                    Group{
                        Text("已累计运动1750分钟")
                            .padding(.horizontal, 20.0)
                            .padding(.vertical,5.0)
                            .background(RoundedRectangle(cornerRadius: 20).fill(lightGreyColor))
                    }.padding(.vertical,10)
                    
                    ScrollView(.vertical) {
                        let columns = [
                            GridItem(),
                            GridItem(),
                            GridItem(),
                            GridItem()
                        ]
                        LazyVGrid(columns: columns) {
                            ForEach(navItems.indices) { (index) in
                                NavigationLink(destination: FilterView(tagId: navItems[index].tagId)) {
                                    VStack(){
                                        Image("bodyPart-\(navItems[index].imgId)")
                                            .navImageModifier()
                                        Text(navItems[index].name)
                                            .foregroundColor(Color.black)
                                    }
                                    .frame(height: 100.0,alignment:.top)
                                }
                            }
                            NavigationLink(destination: FilterView()){
                                VStack{
                                    Image("add")
                                        .navImageModifier()
                                    Text("全部")
                                        .foregroundColor(Color.black)
                                }.frame(height: 100.0,alignment:.top)
                            }
                        }
                    }
                    .padding()
                    .frame(height: 250.0,alignment: .topLeading)
                    
                    showRelatedCourse(courseList: $courseDetailViewModel.hotCourse)
                }
            }.frame(width: .infinity)
        }
        .onAppear(perform: {
            courseDetailViewModel.fetchHotCourse()
        })
        .edgesIgnoringSafeArea(.bottom)
        .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
        )
        
        .navigationBarHidden(true)
    }
}

struct train_Previews: PreviewProvider {
    static var previews: some View {
        Train()
    }
}

struct navBar:View{
    var body: some View{
        HStack(){
            Text("运动")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            NavigationLink(destination: Search().navigationBarHidden(true)
                            .navigationBarTitle("")){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .accentColor(.black)
            }.navigationBarHidden(true)

        }
        .padding(.horizontal,20)
        .padding(.vertical,20)
        .background(Color.white)
    }
}

struct showRelatedCourse:View{
    @Binding var courseList: [CourseNotAction]
    
    enum fontSize:Int{
        case bigSize = 0
        case normalSize = 1
    }
    
    var body:some View{
        VStack{
            Text("热门课程")
                .font(.title2)
                .padding(.horizontal)
                .frame(maxWidth: .infinity,alignment: .topLeading)
            
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(courseList,id:\.courseId) { course in
                            relatedCourseItem(width: 336, height: 228, hasRound: false, course:course,size: .bigSize)
                        }
                    }
                    .frame(height: 120.0)
                }
            
        }.padding(.bottom,20)
    }
}

struct relatedCourseItem: View {
    var width: CGFloat
    var height: CGFloat
    var hasRound: Bool
    
    enum fontSize{
        case bigSize
        case normalSize
    }
    
    @State var course: CourseNotAction
    @State var size: fontSize = .normalSize
    
    var body: some View{
        NavigationLink(destination: CourseDetail(cid: course.courseId)) {
//            VStack(alignment: .center){
//                    Text(course.courseName)
//                        .font(size == .normalSize ? .title2 : .title)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                HStack{
//                    Text("\(course.duration.components(separatedBy: ":")[0])分钟")
//                        .font(size == .normalSize ? .title3 : .title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                    Text("\(course.degree)")
//                        .font(size == .normalSize ? .title3 : .title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                }
//            }
//            .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .background(
//                Image("shareImage")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: width, height: height)
//                    .cornerRadius(hasRound ? 20.0:0.0)
//            )
            ZStack{
                RemoteImage(type: .url(URL(string:course.backgroundUrl)!), errorView: { error in
                       Text(error.localizedDescription)
                   }, imageView: { image in
                       image
                        .aspectRatio(contentMode: .fit)
                        .frame(width: width, height: height)
                        .cornerRadius(hasRound ? 20.0:0.0)
                   }, loadingView: {
                       Text("Loading ...")
                   })
                
                VStack(alignment: .center){
                        Text(course.courseName)
                            .font(size == .normalSize ? .title2 : .title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    HStack{
                        Text("\(course.duration.components(separatedBy: ":")[0])分钟")
                            .font(size == .normalSize ? .title3 : .title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Text("\(course.degree)")
                            .font(size == .normalSize ? .title3 : .title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        
//        ZStack{
//            RemoteImage(type: .url(URL(string:course.backgroundUrl)!), errorView: { error in
//                   Text(error.localizedDescription)
//               }, imageView: { image in
//                   image
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: width, height: height)
//                    .cornerRadius(hasRound ? 20.0:0.0)
//               }, loadingView: {
//                   Text("Loading ...")
//               })
//            
//            VStack(alignment: .center){
//                    Text(course.courseName)
//                        .font(size == .normalSize ? .title2 : .title)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                HStack{
//                    Text("\(course.duration.components(separatedBy: ":")[0])分钟")
//                        .font(size == .normalSize ? .title3 : .title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                    Text("\(course.degree)")
//                        .font(size == .normalSize ? .title3 : .title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.white)
//                }
//            }
//            .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        }
        
        
    }
}

extension Image {
    
    func navImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 48.0, height: 48.0, alignment: .center)
            .padding(.all,5)
            .clipShape(Circle())
            .overlay(Circle().stroke(boldGreyColor, lineWidth: 3))
    }
}
