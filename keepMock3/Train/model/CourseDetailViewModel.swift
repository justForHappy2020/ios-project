//
//  courseDetailViewModel.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/20.
//

import Foundation
import Alamofire
import SwiftyJSON


struct CourseRetDto1:Decodable{
    var courseList: [CourseNotAction]
}

class CourseDetailViewModel: ObservableObject{
    
    @Published var course = Course(courseId: 1, courseName: "", backgroundUrl: "", actions: "", bodyPart: "", degree: "", duration: "", hits: 1,  calorie: 1, courseIntro: "", actionList: [])
    @Published var relativeCourse: [ CourseNotAction ] = []
    @Published var hotCourse: [CourseNotAction] = []
    
    func fetchCourseData(cid:Int){
        
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
        let parameters = [
            "courseId": cid
        ] as [String : Any]
        
       let request = AF.request("http://159.75.2.94:8080/api/course/courseId2Course"
                       ,method: .get
                       ,parameters: parameters
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
        request.responseDecodable(of: responseData<Course>.self) { (response) in
            guard let res = response.value else { return }
            
            switch res.status {
                case .success:
                    self.course = res.data
                    print("self.course = \(self.course)")
                case .failed:
                    print("faild")
            }
        }
    }
    
    func fetchRelativeCourse(cid:Int){
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
        let parameters = [
            "courseId": cid
        ] as [String : Any]
        
        let request = AF.request("http://159.75.2.94:8080/api/course/getRelativeCourse"
                        ,method: .get
                        ,parameters: parameters
                        ,encoding: URLEncoding.default
                        ,headers: headers
                         )
        //该如何使用
        request.responseDecodable(of: responseData<[CourseNotAction]>.self) { (response) in
            print(response)
            guard let res = response.value else { return }
            
            switch res.status {
                case .success:
                    print("success")
                    self.relativeCourse = res.data
                case .failed:
                    print("faild")
            }
        }
    }
    
    func fetchHotCourse(){
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        let request = AF.request("\(baseURL)api/course/getHotCourse10"
                        ,method: .get
                        ,encoding: URLEncoding.default
                        ,headers: headers
                         )
             //该如何使用
        request.responseDecodable(of: responseData<CourseRetDto1>.self) { (response) in
            print(response)
            guard let res = response.value else { return }

            switch res.status {
                case .success:
                    print("success")
                    self.hotCourse = res.data.courseList
                case .failed:
                    print("faild")
        }}
    }
    
    func IsVideoCacheExists(cid:Int)->Bool{
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                    "keepMock",
                    isDirectory: false
            )
            .appendingPathComponent(
                cid.description,
                isDirectory: false
            )
        print("root=\(root)")
        return IsfileExists(path: root.path)
    }
    
    func IsfileExists(path:String) ->Bool{
        let  fileManager = FileManager.default
        let result = fileManager.fileExists(atPath: path)
        if result {
            print("isExitFile")
            return true
        }else{
            print("isNotExitFile at Path \(path)")
            return false
        }
    }
    
}
