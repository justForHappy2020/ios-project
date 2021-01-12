//
//  VideoViewModel.swift
//  Demo
//
//  Created by 悦月越悦 on 2020/12/5.
//

import Foundation
import Alamofire
import VideoPlayer

struct Action:Decodable{
    var actionId: Int
    var actionName: String
    var actionImgs: String
    var actionUrl: String
    var duration:String
    var intro: String
}

struct  Course1:Decodable{
    var courseId: Int
    var courseName: String
    var backgroundUrl: String
    var bodyPart: String
    var degree: String
    var duration: String
    var hits: Int
    var createTime: String
    var calorie: Int
    var courseIntro: String
    var actionList:[Action]
}

class VideoVideoModel: ObservableObject{
    
    @Published var actionList : [Action] = []
    @Published var actionIds: [Int] = []
    @Published var relatedId : Int = 2
    @Published var urls:[URL] = []
    @Published var curIndex: Int = 0
    @Published var play: Bool = true
    
    var total :Int{
        return actionList.count
    }
    
    var curAction: Action{
        var cur = actionList.count > 0 ? actionList[curIndex]: Action(actionId: 1, actionName: "", actionImgs: "", actionUrl: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4", duration: "", intro: "")
        return cur
    }
            
    func getIdOfActions(){
        var ids : [Int] = []
        for action in self.actionList {
            ids.append(action.actionId)
        }
        self.actionIds = ids
    }
    
    func fetchVideoList(){
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
        let parameters = [
            "courseId": relatedId,
        ]
        
        let request = AF.request("http://159.75.2.94:8080/api/course/courseId2Course"
                       ,method: .get
                       ,parameters: parameters
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
        request.responseDecodable(of: responseData<Course>.self) { (response) in
            print(response)
            guard let res = response.value else { return }
            switch res.status {
                case .success:
                    self.play = true
                    self.actionList = res.data.actionList
                    self.getIdOfActions()
                    self.createURL()
                case .failed:
                    print("faild")
            }
        }
    }
    
    func nextAction(){
        if self.curIndex >= (self.total - 1){
            return
        }
        self.play = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.curIndex+=1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.play = true
        }
    }
    
    func previousAction(){
        if self.curIndex <= 0 {
            return
        }
        
        self.play = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
           self.curIndex -= 1
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.play = true
        }
    }
    
    func createURL(){
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                    "keepMock",
                    isDirectory: false
            )
            .appendingPathComponent(
                relatedId.description,
                isDirectory: false
            )
        //生成URLS
        for action in actionList {
            var cachedFile = root
                .appendingPathComponent(
                    "action_\(action.actionId).mp4",
                    isDirectory: false
                )
            urls.append(cachedFile)
        }
        
        print("urls=\(urls)")
        
    }
}



