//
//  method.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/10.
//

import Foundation

//通用方法
func setLocal<T>(key:String,value: T){
    let defaults = UserDefaults.standard
    defaults.set(value, forKey: key)
}

func getLocal(key:String)->String{
    let defaults = UserDefaults.standard
    return defaults.string(forKey: key) ?? ""
}

func setSearchTextToLocal(searchText:String){
    var searchStr = getLocal(key: "searchTexts")
    var searchTexts : [String] = []
    
    if !searchStr.isEmpty{
        searchTexts = searchStr.split(separator: ";").map { String($0) }
    }
    searchTexts.append(searchText)
    
    setLocal(key: "searchTexts", value: searchTexts.joined(separator: ";"))
    print("searchTexts=\(searchTexts)")
}

func getLocalSearchText() -> [String]{
    var searchStr = getLocal(key: "searchTexts")
    return searchStr.split(separator: ";").map { String($0) }
}

func setDefaultSearchText(){
    setLocal(key: "searchTexts", value: "")
}

public extension Array where Element: Equatable {
    
    /// 去除数组重复元素
    /// - Returns: 去除数组重复元素后的数组
    func removeDuplicate() -> Array {
       return self.enumerated().filter { (index,value) -> Bool in
            return self.firstIndex(of: value) == index
        }.map { (_, value) in
            value
        }
    }
}
