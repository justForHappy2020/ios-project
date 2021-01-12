//
//  loginFifth.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/11.
import SwiftUI
import SwiftValidators
import SwiftyJSON
import Alamofire

//
//  userInfoThird.swift
//将保存下来的所有信息Next

import SwiftUI

public extension String {
    //判断字符在字符串中的位置
    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }

    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
}

struct loginFifth: View {
    @State private var height:String = ""
    @State private var weight:String = ""
    @State private var showAlert = false
    @State private var canNext = false
    
    var body: some View {
        NavigationView {
            VStack(){
                Text("完善个人信息")
                    .modifier(AboutHeadingStyle())
                Text("填写个人信息有助于热量计算")
                    .modifier(AboutDescStyle())
                
                Text("身高")
                
                HStack{
                    TextField("请输入您的身高",text: $height)
                        .padding()
                        .border(boldGreyColor)
                        .padding(.vertical,30)
                    Text("CM")
                }
                
                
                Text("体重")
                
                HStack{
                    TextField("请输入您的身高",text: $weight)
                        .padding()
                        .border(boldGreyColor)
                        .padding(.vertical,30)
                    Text("KG")
                }
                
                NavigationLink(destination: Tabs().navigationBarHidden(true),isActive:$canNext) {
                    Button(action: {
                        if(!(self.height.isEmpty && self.weight.isEmpty)){
                            if(!(checkIpt(str: self.height) && checkIpt(str: self.weight))){
                                self.showAlert = true
                            }else{
                                setUserProfile()
                            }
                        }else{
                            setUserProfile()
                        }
                    }, label: {
                        Text("下一步")
                            .modifier(ButtonStyle())
                            .background(boldGreenColor)
                            .modifier(ButtonRadius())
                    }).padding(.bottom,20)
                    .alert(isPresented: self.$showAlert, content: {
                        Alert(title: Text("提示"),
                              message: Text("请填入一位小数"),
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
                alignment: .top)
            .edgesIgnoringSafeArea(.all)
        }
    }

    func setUserProfile(){

        let parameters = [
            "userId": getLocal(key: "uid"),
            "nickname": getLocal(key: "nickName"),
            "gender": getLocal(key: "gender"),
            "headPortraitUrl": getLocal(key: "avatar") == nil ? getLocal(key: "avatar") : "",
            "weight": weight.isEmpty ? Double(weight):0.0,
            "height": height.isEmpty ? Double(height):0.0
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
                   "Content-Type": "application/json"
               ]
        
        AF.request("http://127.0.0.1:8080/api/user/setProfile"
                       ,method: .post
                       ,parameters: parameters
                       ,encoding: JSONEncoding.default
                       ,headers: headers
                        )
            //该如何使用
                .responseJSON{ (response) in
                    let res = JSON(response.data)
                    print(response)
                    if(res["code"]==200){
                        print(res)
                        let token = res["data"]["token"].stringValue
                        print(token)
                        setLocal(key: "token",value: token)
                        self.canNext = true
                    }
        
        }
    }
    
    func checkIpt(str: String) -> Bool {
        
        if(!str.isDouble) {
            return false
        }
        
        if(!(judgeNumberDigit(numStr: str) == 1)) {
            return false
        }
        
        return true
    }

    func judgeNumberDigit(numStr:String) -> Int {
        let dotPos = numStr.indexInt(of: ".")!
        let size = numStr.count  - (dotPos+1)
        return size
    }
}





struct userInfoThird_Previews: PreviewProvider {
    static var previews: some View {
        loginFifth()
    }
}
