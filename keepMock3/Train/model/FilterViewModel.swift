//
//  filterList.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/15.
//

import Foundation
import Alamofire
import SwiftyJSON

struct filterDetail: Identifiable {
    let id = UUID()
    var tagId: Int
    var name: String
    var isChecked: Bool = false
}

class FilterViewModel: ObservableObject{
    
    @Published var filterBodyItems :[filterDetail] =  []
    @Published var filterDegreeItems :[filterDetail] = []
    //获取检索词
    @Published var selectBodyPart : [Int] = []
    @Published var selectDegree: [Int] = []
    
    var searchBodyPart :String{
        print("选择bodyPart的结果是")
        print(selectBodyPart)
        print("selectBodyPartStr=\(selectBodyPart.map { String($0) }.joined(separator: ";"))")
        return selectBodyPart.map { String($0) }.joined(separator: ";")
    }
    
    var searchDegree :String{
        print("选择degree的结果是")
        print(selectBodyPart)
        return selectDegree.map { String($0) }.joined(separator: ";")
    }
    
    func clearSelect(){
        var bodyFilteredIndices = filterBodyItems.indices.filter { filterBodyItems[$0].isChecked }
        var degreeFilteredIndices = filterDegreeItems.indices.filter { filterDegreeItems[$0].isChecked }
        for idx in bodyFilteredIndices {
            filterBodyItems[idx].isChecked = false
        }
        for idx in degreeFilteredIndices {
            filterDegreeItems[idx].isChecked = false
        }
    }
    
    func FetchCourseClassData(tagId:Int) {
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
       let request = AF.request("http://159.75.2.94:8080/api/course/getFilter"
                       ,method: .get
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
       request.responseJSON{ (response) in
                let res = JSON(response.data)
                if(res["code"]==200){
    
                    for tag in res["data"]["bodyPart"].arrayValue{
                        self.addTag(name: tag["classValue"].stringValue, tagId: tag["courseClassId"].intValue, type: 1)
                    }
                    
                    
                    for tag in res["data"]["degree"].arrayValue{
                        print("degreeId=\(tag["courseClassId"].intValue)")
                        self.addTag(name: tag["classValue"].stringValue, tagId: tag["courseClassId"].intValue, type: 2)
                    }
                    
                    if(tagId != 0){
                        if let index =  self.filterBodyItems.firstIndex(where: {$0.tagId == tagId}){
                            self.filterBodyItems[index].isChecked = true
                            print("self.filterBodyItems[index].isChecked=\(self.filterBodyItems[index].isChecked)")
                        }
                    }
                }
    
            }

    }
    
    func addTag(name:String,tagId:Int,type:Int){
        let tag = filterDetail(tagId: tagId, name: name)
        
        if(type == 1){
            self.filterBodyItems.append(tag)
            return
        }
        
        if(type == 2){
            self.filterDegreeItems.append(tag)
            return
        }
    }
    
    func getSearchText(){
        var bodyFilteredIndices = filterBodyItems.indices.filter { filterBodyItems[$0].isChecked }
        var degreeFilteredIndices = filterDegreeItems.indices.filter { filterDegreeItems[$0].isChecked }
        
        for idx in bodyFilteredIndices {
            selectBodyPart.append(filterBodyItems[idx].tagId)
        }
        for idx in degreeFilteredIndices {
            selectDegree.append(filterDegreeItems[idx].tagId)
        }
        
        print("selectBodyPart=\(selectBodyPart)")
        print("selectDegree=\(selectDegree)")
    }
}


