//
//  SearchAll.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/31.
//

import SwiftUI

struct SearchResult: View {
    @State var searchText = ""
    @State private var selectedTab = 0
    private let triathlonSports = ["综合", "课程","用户","动态"]
    
    var body: some View {
        VStack(){
            VStack(spacing: 100) {
                Picker(selection: $selectedTab, label: Text("Select a Sport")) {
                    ForEach(0 ..< triathlonSports.count) {
                        Text(self.triathlonSports[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            
            switch selectedTab {
                case 0 :
                    all()
                case 1 :
                    SearchCourse(searchText:searchText)
                case 2 :
                    user()
                case 3 :
                    share()
                default:
                    all()
            }
            
        }
        .padding(.bottom)
        .frame(
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResult(searchText: "123")
    }
}
