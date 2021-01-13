//
//  SeachAllViewModel.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/21.
//

import Foundation

struct searchItem: Identifiable {
    let id = UUID()
    var name : String
}

extension searchItem: Equatable {
  static func ==(lhs: searchItem, rhs: searchItem) -> Bool {
    return lhs.name == rhs.name
  }
}

class SearchHistoryModel: ObservableObject{
    @Published var searchTexts : [searchItem] = []
    
    func getSearchTexts(){
        let searchTexts = getLocalSearchText()
        for  item in searchTexts {
            self.searchTexts.append(searchItem(name: item))
        }
        self.searchTexts = self.searchTexts.removeDuplicate()
    }
    
    func setSearchText(searchText:String){
        searchTexts.append(searchItem(name: searchText))
        setSearchTextToLocal(searchText: searchText)
    }
    
    func clearSearchText(){
        self.searchTexts = []
        setDefaultSearchText()
    }
}
