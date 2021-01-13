//
//  successView.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/12/11.
//

import SwiftUI

struct SuccessView: View{
    @State var cid: Int
    @State var end: Bool = false
    let courseDetailViewModel = CourseDetailViewModel()
    
    var body: some View {
        VStack(alignment: .center){
            Group{
                Image("success")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                   
                Text("锻炼已完成!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }.padding(.bottom,10)
            
            HStack(){
                VStack{
                    Text("时长")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(boldGreyColor)
                        .padding(.bottom,5)
                    HStack{
                        Text("8")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("mins")
                            .foregroundColor(boldGreyColor)
                    }
                }
                Spacer()
                VStack{
                    Text("消耗")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(boldGreyColor)
                        .padding(.bottom,5)
                    HStack{
                        Text("87")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Kcal")
                            .foregroundColor(boldGreyColor)
                    }
                }
            }.padding(.bottom,50)
            
            
            Button(action: {
                end = true
            }) {
                Text("完成")
                    .fontWeight(.semibold)
                    .font(.title)
                    .padding(.horizontal,100)
                    .padding(.vertical,10)
                    .foregroundColor(.white)
                    .background(lightGreenColor)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: HomeView().navigationBarHidden(true).navigationBarTitle(""),isActive:$end) {
                EmptyView()
            }
        }
        .onAppear(perform: {
            courseDetailViewModel.fetchCourseData(cid: cid)
        })
        .padding(.horizontal,40)
        .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
        )
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct successView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(cid: 2)
    }
}
