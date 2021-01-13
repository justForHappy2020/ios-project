//将性别存在本地然后next

import SwiftUI

struct loginFourth: View {
    @State private var selectSex = "W"
    @State private var canNext: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(){
                Text("完善个人信息")
                    .modifier(AboutHeadingStyle())
                
                Text("填写个人信息有助于热量计算")
                    .modifier(AboutDescStyle())
                
                Text("您的性别")
                
                HStack{
                    
                    Button(action: {
                        self.selectSex = "W"
                    }) {
                        Image("female")
                            .resizable()
                            .scaledToFit()
                            .frame(width:130,height: 174)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(selectSex == "W" ? lightGreenColor : Color.white, lineWidth: 5)
                            )
                            .padding()
                    }
                    
                    Button(action: {
                        self.selectSex = "M"
                    }) {
                        Image("male")
                            .resizable()
                            .scaledToFit()
                            .frame(width:130,height: 174)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(selectSex == "M" ? lightGreenColor : Color.white, lineWidth: 5)
                            )
                            .padding()
                    }
                    
                }
                .padding(.bottom,30)
                            
                NavigationLink(destination: loginFifth().navigationBarHidden(true),isActive: $canNext){
                    Button(action: {
                        setLocal(key: "gender", value: self.selectSex)
                        self.canNext = true
                    }, label: {
                        Text("确定")
                            .modifier(ButtonStyle())
                            .background(boldGreenColor)
                            .modifier(ButtonRadius())
                    }).padding(.bottom,20)
                }
            }
            .padding(.top,90)
            .padding()
            .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct userInfoSecond_Previews: PreviewProvider {
    static var previews: some View {
        loginFourth()
    }
}
