//
//  VideoPlayView.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/12/5.
//

import AVFoundation
import SwiftUI
import VideoPlayer
import SlideOverCard

struct VideoPlayView: View {
    @State private var time: CMTime = .zero
    @State private var totalDuration: Double = 0
    @ObservedObject var videoViewModel = VideoVideoModel()
    @State private var position = CardPosition.bottom
    @State var relatedId:Int
    
    //传入一个actionViewModel
    @ObservedObject var actionViewModel = ActionViewModel()
    
    //暂停页
    @State var showPause = false
    //成功页
    @State var showSuccess = false

    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if videoViewModel.urls.count > 0{
                    VideoPlayer(url: videoViewModel.urls[videoViewModel.curIndex], play: $videoViewModel.play, time: $time)
                        .onPlayToEndTime {
                            if(videoViewModel.curIndex == videoViewModel.urls.count - 1){
                                showSuccess = true
                            }else{
                                videoViewModel.nextAction()
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                NavigationLink(destination: SuccessView(cid: relatedId).navigationBarHidden(true).navigationBarTitle("")
                               ,isActive:$showSuccess) {
                    EmptyView()
                }
            }
            
            VStack(spacing: 0){
                HStack{
                    Spacer()
                    Button(action: {
                        self.position = CardPosition.top
                        videoViewModel.play = false
                        print("self.position = \(self.position)")
                    }) {
                        VStack{
                            Text("查看")
                            Text("讲解")
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.gray)
                        .clipShape(Circle())
                    }
                }
                .padding(.trailing,20)
                .frame(minWidth: 0,maxWidth: .infinity)
                
                Spacer()
                
                HStack{
                    Text("\(videoViewModel.curIndex + 1)/\(videoViewModel.total)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(videoViewModel.curAction.actionName)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                
                HStack{
                    Button(action:{
                        self.videoViewModel.previousAction()
                    }) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(videoViewModel.curIndex == 0 ? Color.gray : Color.blue )
                    }
                    .disabled(videoViewModel.curIndex == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        self.videoViewModel.play = false
                        self.showPause = true
                    }) {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 32, weight: .bold))
                    }
                    
                    NavigationLink(destination: PauseView(cid: relatedId, play: self.$videoViewModel.play, showPause: $showPause),isActive:$showPause){
                        EmptyView()
                    }
                    
                    Spacer()
                    
                    
                    Button(action:{
                        self.videoViewModel.nextAction()
                    }){
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(videoViewModel.curIndex == (videoViewModel.total - 1) ? Color.gray : Color.blue)
                    }
                    .disabled(videoViewModel.curIndex == (videoViewModel.total - 1))
                    
                }
                .padding()
            }
            
            ActionView(position: Binding(get: {
                self.position
            }, set: {
                self.position = $0
                if(self.position == CardPosition.bottom){
                    videoViewModel.play = true
                }

            }), actionViewModel: actionViewModel)
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear(){
            //当打开的时候就去获取信息
            videoViewModel.relatedId = relatedId
            actionViewModel.relatedId = relatedId
            
            videoViewModel.fetchVideoList()
            actionViewModel.fetchActionDataBycid()
        }
    }
}

struct VideoPlayView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayView(relatedId: 2)
    }
}
