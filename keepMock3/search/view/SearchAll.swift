//
//  SearchAll.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/11/1.
//

import SwiftUI
//import SwiftUILib_WrapStack

struct SearchAll: View {
    @State private var searchText = ""
    @ObservedObject var  searchAllViewModel = SearchHistoryModel()
    
    var body: some View {
        NavigationView {
            VStack(){
//                searchBar()
                
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
                        ForEach(searchAllViewModel.searchTexts.indices) { idx in
                            searchItemView(search: self.$searchAllViewModel.searchTexts[idx])
                        }
                    }
                    

                }
                .padding()
                
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
            .background(bgGrey)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct searchItemView: View {
    @Binding var search: searchItem
    var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(boldGreenColor)
                        .frame(width: 60, height: 30)
            .overlay(Text(search.name).foregroundColor(.white))
    }
        
}


struct SearchAll_Previews: PreviewProvider {
    static var previews: some View {
        SearchAll()
    }
}
