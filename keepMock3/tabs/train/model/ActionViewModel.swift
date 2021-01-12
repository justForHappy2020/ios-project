//
//  ActionViewModel.swift
//  testDrawer
//
//  Created by 悦月越悦 on 2020/12/9.
//

import Foundation
import Alamofire

struct ActionDetail:Decodable{
    var actionId:Int
    var actionName:String
    var actionUrl: String
    var duration: String
    var introId: Int
    var intro: String
}

class ActionViewModel : ObservableObject{
    //数据
    @Published var actionList :[ActionDetail] = []
    @Published var curIdx = 0
    @Published var relatedId : Int = 1
    
    var total :Int{
        return actionList.count
    }
    
    func fetchActionDataBycid(){
        
        var headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
        var parameters = [
            "id": self.relatedId,
        ]
        
        let request = AF.request("https://www.fastmock.site/mock/774dcf01fef0c91321522e08613b412e/api/api/community/courseId2ActionList"
                       ,method: .get
                       ,parameters: parameters
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
        request.responseDecodable(of: responseData<[ActionDetail]>.self) { (response) in
            print(response)
            guard let res = response.value else { return }

            switch res.status {
                case .success:
                    self.actionList = res.data
                case .failed:
                    print("faild")
            }
        }
        
    }
    
    func getNextAction(){
        if self.curIdx >= (self.total - 1){
            return
        }
        
        self.curIdx += 1
    }
    
    func getPreviousAction() {
        if self.curIdx <= 0 {
            return
        }
        self.curIdx -= 1
    }
}

