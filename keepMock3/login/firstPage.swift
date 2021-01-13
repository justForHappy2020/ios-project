//
//1⃣️判断本地是否存在token,如果存在则跳转首页，如果不存在则跳转到1

import SwiftUI
import Alamofire

struct firstPage: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView{
            
            NavigationLink(destination: getDestination().navigationBarHidden(true)   // here !!
                .navigationBarTitle(""),isActive: $isActive) {
                VStack(){
                    Text("运动使人快乐")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .frame(
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center)
                .background(bgColor)
                .edgesIgnoringSafeArea(.all)
            }
        }.onAppear(perform: {
            self.gotoLoginScreen(time: 1)
        })
    }
    
    func gotoLoginScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            self.isActive = true
        }
    }
    
    func getDestination() -> AnyView {
        clearDefault()
        
        let token = getLocal(key: "token");
        
        if(token.isEmpty){
            return AnyView(loginFirst())
        }
        
        return AnyView(HomeView())
    }
    
    func clearDefault(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}


struct firstPage_Previews: PreviewProvider {
    static var previews: some View {
        firstPage()
    }
}

