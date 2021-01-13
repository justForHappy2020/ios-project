//
//  VideoCacheView.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/12/25.
//

import SwiftUI

struct VideoCacheView: View {
    private let total:Double = 1
    
    @ObservedObject var videoCacheModel = VideoCacheModel()
    @State var relatedId : Int
//    @EnvironmentObject var cacheFileController: CacheFileController
//    @ObservedObject var videoCacheModel = VideoCacheModel(cacheFileController: )
    var progressText : String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: videoCacheModel.progress)
        let formattedValue = formatter.string(from: number)!
        
        let number1 = NumberFormatter().number(from: formattedValue)!
        formatter.numberStyle = .percent
        let result = formatter.string(from: number1)!
        
        return result
    }
    
    var body: some View{
        NavigationLink(destination: VideoPlayView(relatedId: relatedId),isActive: $videoCacheModel.complete){
            GeometryReader { geometry in
                VStack(){
                    Image("downloadTest")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height-100, alignment: .center)
                    ZStack{
                        ProgressView(value: videoCacheModel.progress, total: 1)
                            .progressViewStyle(MyProgressViewStyle())
                            .frame(height: 100)
                        Text("已经下载\(progressText)")
                    }
                }
                .onAppear(perform: {
                    videoCacheModel.relatedId = relatedId
                    videoCacheModel.fetchActionListAndDownloadVideo()
                })
                .frame(
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading)
            
            }
        }
    }
}

struct MyProgressViewStyle:ProgressViewStyle{
    let foregroundColor:Color
    let backgroundColor:Color
    init(foregroundColor:Color = lightGreenColor,backgroundColor:Color = lightGreenColor.opacity(0.5)){
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader{ proxy in
            ZStack(alignment:.topLeading){
            backgroundColor
            Rectangle()
                .fill(foregroundColor)
                .frame(width:proxy.size.width * CGFloat(configuration.fractionCompleted ?? 0.0),height: proxy.size.height)
            }
            .frame(height:proxy.size.height)
        }
    }
}

struct VideoCacheView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCacheView(relatedId: 1)
    }
}
