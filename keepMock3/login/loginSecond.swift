//
//  loginSecond.swift
//  keepMock1
//1⃣️拉后端接口，判断是否是已经注册过的用户，不是则跳转3，4，5，是则跳转首页
import SwiftUI
import Alamofire
import SwiftyJSON
import AudioToolbox

class TextFieldManager: ObservableObject {
    let characterLimit = 4
    @Published var userInput = ""{
        didSet{
            if userInput.count > characterLimit{
                userInput = String(userInput.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
            }
        }
    }
}

struct loginSecond: View {
    @State var code: String = ""
    @State var alertIsVisible = false
    @State var timeLeft: Int = 60
    @State var canNext:Bool = false
    @State var isNewUser:Bool = true
    
    @ObservedObject var textFieldManager = TextFieldManager()
    
    var timer: Timer {
        return Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            timeLeft -= 1
            if timeLeft <= 0 {
                timer.invalidate()
            }
        })
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("请输入验证码")
                    .modifier(AboutHeadingStyle())
                    .foregroundColor(Color.white)
                
                HStack {
                    Text("已发送4位验证码至")
                        .modifier(AboutDescStyle())
                    Text("+86"+getMobileToUserDefault())
                        .modifier(AboutDescStyle())
                        .foregroundColor(Color.gray)
                }
                
                TextField("请输入验证码",text:$textFieldManager.userInput)
                    .modifier(IptStyle())
                    .keyboardType(.numberPad)
                
                VStack(alignment: .center){
                    NavigationLink(destination: getDestination().navigationBarHidden(true) ,isActive: $canNext){
                        Button(action: {
                            loginOrSignIn()
                        }, label: {
                            Text("确定")
                                .modifier(ButtonStyle())
                                .background(textFieldManager.userInput.isEmpty ? lightGreenColor:boldGreenColor)
                                .modifier(ButtonRadius())
                        }).padding(.bottom,20)
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitle("")
                    .alert(isPresented: self.$alertIsVisible){
                        Alert(title: Text("提示"),message: Text("验证码错误"),dismissButton: .default(Text("确认")))
                    }
                    
                    
                    Button(action: {
                        code(mobile: getMobileToUserDefault())
                    }, label: {
                        Text(timeLeft > 0 ? "重发验证码(\(timeLeft))": "发送验证码")
                            .foregroundColor(timeLeft > 0 ? Color.gray: Color.blue)
                    }).disabled(timeLeft > 0)
                    
                }.frame(maxWidth: .infinity)

            }
            .padding(.top,90)
            .padding()
            .frame(
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
            .background(bgColor)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                countDown()
            }
        }
        
    }
    
    func countDown(){
        self.timeLeft = 60
        timer.fire()
    }
    
    func getMobileToUserDefault()-> String{
        return getLocal(key: "mobile")
    }
    
    func code(mobile:String){
        let parameters = [
            "phoneNumber": mobile,
            "code":code
        ]
        let headers: HTTPHeaders = [
                   "Content-Type": "application/json"
               ]
        AF.request("http://127.0.0.1:8080/api/user/getCode"
                   ,method: .post
                   ,parameters: parameters
                   ,encoding: JSONEncoding.default
                   ,headers: headers
                    )
        //该如何使用
        .responseJSON{ (response) in
            let res = JSON(response.data)
            
            print(res)
            
            if(res["code"]==200){
                countDown()
            }

        }
    }
    
    func loginOrSignIn(){
        let parameters = [
            "phoneNumber": getMobileToUserDefault(),
            "code":textFieldManager.userInput
        ]
        let headers: HTTPHeaders = [
                   "Content-Type": "application/json"
               ]
        AF.request("http://127.0.0.1:8080/api/user/login"
                   ,method: .post
                   ,parameters: parameters
                   ,encoding: JSONEncoding.default
                   ,headers: headers
                    )
        //该如何使用
            .responseJSON{ (response) in
                let res = JSON(response.data)
                let data = res["data"]
                
                print(data)
               
                if(res["code"]==200){
                    //解构
                    let isNewUser = data["newUser"].boolValue
                    let userId = data["userId"].intValue
                    //设置
                    self.isNewUser = isNewUser
                    
                    print("isNewUser")
                    print(isNewUser)
                    
                    setLocal(key: "uid", value: userId)
                    self.canNext = true
                    
                }else{
                    self.alertIsVisible = true
                }

            }
    }
    
    func getDestination() -> AnyView {
        if(self.isNewUser){
            return AnyView(loginThird())
        }
        
        return AnyView(Tabs())
    }
    
}


struct getCode_Previews: PreviewProvider {
    static var previews: some View {
        loginSecond()
    }
}
