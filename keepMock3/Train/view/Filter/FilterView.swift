//
//  filter.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/31.
//

import SwiftUI
//import SwiftUILib_WrapStack


struct FilterView: View {
    @State var tagId: Int = 0
    @ObservedObject var filterList = FilterViewModel()
    @ObservedObject var viewModel: CourseViewModel = CourseViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader{geometry in
            VStack(){
                VStack(){
                    HStack(){
                        Image(systemName: "arrow.backward")
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        Spacer()
                        Text("全部课程")
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }
                    .padding()
                    
                    Divider()

                    HStack(){
                        Text("部位")
                            .font(.title3)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(filterList.filterBodyItems.indices,id: \.self){
                                    idx in FilterItem(name: self.$filterList.filterBodyItems[idx].name,isChecked:self.$filterList.filterBodyItems[idx].isChecked)
                                        .onTapGesture {
                                            if let matchingIndex = self.filterList.filterBodyItems.firstIndex(where: { $0.id == self.filterList.filterBodyItems[idx].id }){
                                                print(matchingIndex)
                                                self.filterList.filterBodyItems[matchingIndex].isChecked.toggle()
                                                print(self.filterList.filterBodyItems[matchingIndex].isChecked)
                                            }
                                        }
                                }
                            }.padding(.all,5)
                        }
                    }
                    .padding(.leading,10)
                    
                    HStack(){
                        Text("难度")
                            .font(.title3)
                            .fontWeight(.bold)
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(filterList.filterDegreeItems.indices,id: \.self){
                                    idx in FilterItem(name: self.$filterList.filterDegreeItems[idx].name,isChecked:self.$filterList.filterDegreeItems[idx].isChecked)
                                        .onTapGesture {
                                            if let matchingIndex = self.filterList.filterDegreeItems.firstIndex(where: { $0.id == self.filterList.filterDegreeItems[idx].id }){
                                                print(matchingIndex)
                                                self.filterList.filterDegreeItems[matchingIndex].isChecked.toggle()
                                                print(self.filterList.filterDegreeItems[matchingIndex].isChecked)
                                            }
                                        }
                                }
                            }.padding(.all,5)
                            
                        }
                    }
                    .padding(.leading,10)
                        
                        HStack{
                            Text("重置")
                                .frame(width: geometry.size.width / 3, height: 30)
                                .background(boldGreenColor)
                                .foregroundColor(.white)
                                .onTapGesture(perform: {
                                    filterList.clearSelect()
                                    viewModel.setStateToDefault()
                                    viewModel.searchBodyPart = ""
                                    viewModel.searchDegree = ""
                                    viewModel.fetchNextPageIfPossible()
                                })

                            Spacer()

                            Text("确定")
                                .frame(width: geometry.size.width / 3, height: 30)
                                .background(Color.white)
                                .foregroundColor(boldGreenColor)
                                .border(boldGreenColor,width: 2)
                                .onTapGesture(perform: {
                                    filterList.getSearchText()
                                    viewModel.setStateToDefault()
                                    viewModel.searchBodyPart = filterList.searchBodyPart
                                    viewModel.searchDegree = filterList.searchDegree
                                    viewModel.fetchNextPageIfPossible()
                                })

                        }
                        .padding(.all,10)
                        .frame(maxWidth:.infinity)
                      
                }
                .background(Color.white)
                .frame(
                    maxWidth: .infinity,
                    alignment: .topLeading)
                
                ScrollView {
                    CourseList(courses: viewModel.state.dataList, isLoading: viewModel.state.canLoadNextPage, onScrolledAtBottom: viewModel.fetchNextPageIfPossible)
                        .onAppear(perform: {
                            print("tagId=\(tagId)")
                            filterList.FetchCourseClassData(tagId:tagId)
                            viewModel.searchBodyPart = (tagId == 0 ? "" : "\(tagId)")
                            viewModel.searchDegree = ""
                            viewModel.fetchNextPageIfPossible()
                        })
                }
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
            .background(bgGrey)
            .edgesIgnoringSafeArea(.bottom)
            
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}


struct selectButton: View {
    var body: some View {
        Button(action: {}) {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(boldGreenColor)
                            .frame(width: 60, height: 30)
                            .overlay(Text("腿部").foregroundColor(.white))
        }
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
