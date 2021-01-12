//
//  courseViewModel.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/18.
//

import Alamofire
import SwiftyJSON

struct CourseRetDto:Decodable{
    var courseList: [CourseNotAction]
    var hasNext: Bool
    var totalPages: Int
}

struct Course:Decodable,Equatable{
    var courseId: Int
    var courseName: String
    var backgroundUrl: String
    var actions: String
    var bodyPart: String
    var degree: String
    var duration: String
    var hits: Int
    var calorie: Int
    var courseIntro: String
    var actionList: [Action]
}

struct CourseNotAction:Decodable,Equatable{
    var courseId: Int
    var courseName: String
    var backgroundUrl: String
    var actions: String
    var bodyPart: String
    var degree: String
    var duration: String
    var hits: Int
    var calorie: Int
    var courseIntro: String
}

extension Course {
    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.courseId == rhs.courseId
    }
}

enum dataUrl: String  {
    case relativeUrl = "http://159.75.2.94:8080/api/course/filterCourse"
    case searchUrl = "http://159.75.2.94:8080/api/course/searchCourse"
}

/// 分页器
class CourseViewModel: Pagination<CourseNotAction>{
    @Published var searchBodyPart = ""
    @Published var searchDegree = ""
    @Published var searchText = ""
    @Published var dataSource : dataUrl = dataUrl.relativeUrl

    func fetchNextPageIfPossible(){
        guard state.canLoadNextPage else { return }
        
        var parameters : [String : Any]
        
        var headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
    
        switch self.dataSource{
            case .relativeUrl:
                parameters = [
                    "bodyPart": searchBodyPart,
                    "degree": searchDegree,
                    "currentPage": state.page + 1
                ]
                
            case .searchUrl:
                parameters = [
                    "keyword": searchText,
                    "currentPage": state.page + 1
                ]
        }
        
        let request = AF.request(dataSource.rawValue
                       ,method: .get
                       ,parameters: parameters
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
        request.responseDecodable(of: responseData<CourseRetDto>.self) { (response) in
            print("search=\(response)")
            guard let res = response.value else { return }

            switch res.status {
                case .success:
                    print("search")
                    print(response)
                    self.state.dataList += res.data.courseList
                    self.state.canLoadNextPage = res.data.hasNext
                    self.state.page += 1
                    
                case .failed:
                    print("faild")
            }
        }
    }
}

class Pagination<T>: ObservableObject{
    @Published var state = State<T>()
    
    func setStateToDefault(){
        state.dataList = []
        state.page = 0
        state.canLoadNextPage = true
    }
    
    struct State<T> {
        var dataList: [T] = []
        var page: Int = 0
        var canLoadNextPage = true
    }
}
