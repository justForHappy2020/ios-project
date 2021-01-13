//
//  PauseView.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/12/11.
//

import SwiftUI

struct PauseView: View {
    @State var cid : Int
    @Binding var play: Bool
    @Binding var showPause: Bool
    @State var end:Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            HStack{
                NavigationLink(destination: CourseDetail(cid: cid),isActive:$end) {
                    //这里要封装成一个Button的View
                    VStack{
                        ZStack{
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 100, height: 100)
                            Image(systemName: "pause.fill")
                                .font(.system(size: 48, weight: .bold))
                        }
                        .padding()
                        .onTapGesture {
                            end = true
                        }
                        Text("退出训练")
                    }
                }
                //这里要封装成一个Button的View
                VStack{
                    ZStack{
                        Circle()
                            .fill(lightGreenColor)
                            .frame(width: 100, height: 100)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.system(size: 48, weight: .bold))
                    }
                    .padding()
                    .onTapGesture {
                        play = true
                        showPause = false
                    }
                    Text("继续训练")
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: .center
            )
            Spacer()
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
