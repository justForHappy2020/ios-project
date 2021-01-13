import SwiftUI
//import SwiftUILib_WrapStack

struct all: View {
    var body: some View {
        GeometryReader{geometry in
            VStack(){
                VStack(alignment: .leading){
                    Text("课程")
                        .padding(.all,20)
                    
                    VStack(){
                        commonListItem()
                    }
                    .padding(.horizontal,20)
                    
                    Divider()
                    
                    Button(action: {}) {
                        Text("查看更多")
                    }
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity ,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                

                Rectangle()
                    .fill(lightGreyColor)
                    .frame(height: 10)
                
                VStack(alignment: .leading){
                    Text("动态")
                    
//                    WHStack(spacing:10){
//                        shareItem(width: (geometry.size.width - 50) / 2)
//                        shareItem(width: (geometry.size.width - 50) / 2)
//                        shareItem(width: (geometry.size.width - 50) / 2)
//                        shareItem(width: (geometry.size.width - 40) / 2)
//                    }
                    
                    Divider()
                    
                    Button(action: {}) {
                        Text("查看更多")
                    }
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity ,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding(.all,20)
                
                Rectangle()
                    .fill(lightGreyColor)
                    .frame(height: 10)
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

struct searchCourseItem: View {
    var body: some View {
        Image("sport")
            .resizable()
            .aspectRatio(contentMode: .fit)
        VStack(){
            Text("我学过的课程")
            Text("27节课程")
        }
        Image(systemName: "chevron.right")
    }
}

struct shareItem: View{
    @State var width:CGFloat
    var body: some View{
        VStack{
            Image("shareImage").resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: width,
                       maxHeight: 128)
                .clipped()
            
            Text("运动减肥打卡，慢跑10公里")
                .lineLimit(1)
            HStack(){

                Image("avatar")
                Text("张雨绮")
                
                Spacer()
                Image(systemName: "hand.thumbsup")
                Text("815")
            }
        }.frame(width: width)
    }
}

struct commonListItem: View {
    var body: some View {
        HStack{
            Image("shareImage")
                .resizable()
                .frame(width:60,height:60)

            VStack(alignment: .leading){
                Text("我学过的课程")
                Text("27节课程")
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
    }
}


struct all_Previews: PreviewProvider {
    static var previews: some View {
        all()
    }
}
