import SwiftUI
import SlideOverCard

struct ActionView: View {
    @Binding var position : CardPosition
    @State private var background = BackgroundStyle.blur
    @ObservedObject var actionViewModel : ActionViewModel
    @State var actionId = 0
    
    //在不同的情况下显示不同的底部
    @State var showStartBtn:Bool = false
    @State var cid:Int  = 0
    @State var startVideo: Bool = false
    
    var visible:Bool{
        if position == CardPosition.bottom{
            return false
        }
        return true
    }
    
    var body: some View {
        GeometryReader{geometry in
            if visible{
                SlideOverCard($position, backgroundStyle: $background) {
                    VStack {
                        HTMLStringView(htmlContent: actionViewModel.actionList[actionViewModel.curIdx].intro)
                            .frame(height: geometry.size.height - 180)
                        Spacer()
                        HStack{
                            Button(action: {
                                actionViewModel.getPreviousAction()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(actionViewModel.curIdx == 0 ? Color.gray : Color.blue )
                            })
                            .disabled(actionViewModel.curIdx == 0)
                            
                            Button(action: {
                                actionViewModel.getNextAction()
                            }, label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(actionViewModel.curIdx == (actionViewModel.total - 1) ? Color.gray : Color.blue)
                            })
                            .disabled(actionViewModel.curIdx == (actionViewModel.total - 1))
                            
                            Spacer()
                            
                            if showStartBtn{
                                Button(action: {
                                    startVideo = true
                                }) {
                                    Text("开始训练")
                                        .padding()
                                        .background(boldGreenColor)
                                        .cornerRadius(40)
                                        .foregroundColor(.white)
                                        .padding(10)
                                }
                                NavigationLink(destination: VideoPlayView(relatedId: cid),isActive:$startVideo) {
                                    EmptyView()
                                }
                            }
                            
                        }
                        .padding(.bottom,80)
                        .padding(.horizontal,20)
                        
                    }
                        .onAppear(perform: {
                            if(self.actionId != 0){
                                actionViewModel.curIdx = actionId
                            }
                        })
                }
            }
        }
    }
}
