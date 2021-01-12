import SwiftUI
import Alamofire
import SwiftyJSON
import SwiftValidators

struct loginFirst: View {
    @State private var mobile:String = ""
    @State private var showAlert:Bool = false
    @State private var alertMessage: String = ""
    @State private var canNext: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                    Text("手机号登录/注册")
                        .modifier(AboutHeadingStyle())
                        .foregroundColor(Color.white)
                    Text("快速找到好友，一站式记录你的运动")
                        .modifier(AboutDescStyle())
                    TextField("请输入手机号", text: $mobile)
                        .modifier(IptStyle())
                        .keyboardType(.numberPad)
                    
                    NavigationLink(destination: loginSecond().navigationBarHidden(true),isActive: $canNext) {
                        Button(action: {
                            checkPhoneNumber(mobile: self.mobile)
                        }, label: {
                            Text("获取验证码")
                                .modifier(ButtonStyle())
                                .background(mobile.isEmpty ? lightGreenColor: boldGreenColor)
                                .modifier(ButtonRadius())
                        }).alert(isPresented: self.$showAlert, content: {
                            Alert(title: Text("提示"),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text("确定")))
                        })
                        
                    }
                }
                .padding(.top,90)
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
    
    func checkPhoneNumber(mobile:String){
        
        if(Validator.isEmpty().apply(self.mobile)){
            showAlert = true
            return alertMessage = "手机号码不能为空"
        }
        
        if(!Validator.isPhone(.zh_CN).apply(self.mobile)){
            showAlert = true
            return  alertMessage = "手机号码格式错误"
        }
        
        print("验证成功")
        code(mobile:self.mobile)
        
    }
    
    func setMobileToUserDefault(mobile:String){
        let defaults = UserDefaults.standard
        defaults.set(mobile, forKey: "mobile")
    }

    func code(mobile:String){
        let parameters = [
            "phoneNumber": mobile
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
                    if(res["code"]==200){
                        setLocal(key: "mobile", value: mobile)
                        canNext = true
                    }
        
                }
    }
}

struct loginFirst_Previews: PreviewProvider {
    static var previews: some View {
        loginFirst()
    }
}
