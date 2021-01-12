//
//  SearchHistoryView.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/22.
//

import SwiftUI

struct SearchHistoryView: View {
    @ObservedObject var  searchAllViewModel = SearchHistoryModel()
    @Binding var searchText:String
    
    var body: some View {
        VStack(){
            HStack(alignment: .top){
                Text("历史搜索")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom,10)
                
                Spacer()
                
                Group{
                    Image(systemName: "trash")
                    Text("清除记录")
                }
                .onTapGesture(perform: {
                    searchAllViewModel.clearSearchText()
                })
            }
            .padding(.bottom,10)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(searchAllViewModel.searchTexts.indices,id:\.self) { idx in
                        searchItemView(search: self.$searchAllViewModel.searchTexts[idx])
                            .onTapGesture(perform: {
                                self.searchText = self.searchAllViewModel.searchTexts[idx].name
                            })
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: {
            searchAllViewModel.getSearchTexts()
            print(searchAllViewModel.searchTexts)
        })
    }
}
