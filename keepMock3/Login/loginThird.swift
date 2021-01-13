//
//  userInfoSecond.swift
//  keepMock
//
//  Created by 悦月越悦 on 2020/10/23.
//1⃣️上传头像到服务器，将获得的URL存在本地
//2⃣️昵称的输入控制
//3⃣️点击下一步之后将URL和头像存在本地
import SwiftUI
import SwiftValidators
import SwiftyJSON
import Alamofire

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  @Binding var uploadImg: UIImage?

  init(isShown: Binding<Bool>, image: Binding<Image?>,uploadImg:Binding<UIImage?>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _uploadImg = uploadImg
  }

  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
     uploadImg = unwrapImage
     isCoordinatorShown = false
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

struct CaptureImageView {
  /// TODO 2: Implement other things later
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uploadImg: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image,uploadImg: $uploadImg)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct loginThird: View {
    @State private var nickName:String = ""
//    相册
    @State private var image: Image? = nil
    @State private var uploadImg: UIImage? = nil
    @State private var showCaptureImageView: Bool = false
    @State private var getByAlbum: Bool = false
// 点击下一步按钮
    @State private var showAlert:Bool = false
    @State private var alertMessage: String = ""
    @State private var canNext: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(){
                Text("完善个人信息")
                    .modifier(AboutHeadingStyle())
                Text("填写个人信息有助于热量计算")
                    .modifier(AboutDescStyle())
                
                if(image == nil){
                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }){
                        VStack{
                            Image("camera")
                            Text("上传头像")
                                .foregroundColor(boldGreyColor)
                        }
                        .padding(.all,30.0)
                        .overlay(
                            Circle()
                                .stroke(boldGreyColor,lineWidth: 2)
                        )
                    }
                }
                
                image?.resizable()
                  .frame(width: 130, height: 130)
                  .clipShape(Circle())
                    .overlay(Circle().stroke(boldGreyColor, lineWidth: 2))
                
                if(image != nil){
                    Button(action:{
                        self.showCaptureImageView.toggle()
                    }){
                        Text("重新上传")
                    }
                }
                
                
                TextField("请输入昵称",text: $nickName)
                    .padding()
                    .border(boldGreyColor)
                    .padding(.vertical,30)
                
                NavigationLink(destination: loginFourth().navigationBarHidden(true),isActive: $canNext) {
                    Button(action: {
                        checkInput()
                    }, label: {
                        Text("下一步")
                            .modifier(ButtonStyle())
                            .background(nickName.isEmpty ? lightGreenColor:boldGreenColor)
                            .modifier(ButtonRadius())
                    })
                    .alert(isPresented: self.$showAlert, content: {
                        Alert(title: Text("提示"),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("确定")))
                    })
                    .padding(.bottom,20)
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
        if (showCaptureImageView) {
            CaptureImageView(isShown: $showCaptureImageView, image: $image,uploadImg: $uploadImg)
        }
    }
    
    func checkInput(){
        if(Validator.isEmpty().apply(self.nickName)){
            showAlert = true
            return alertMessage = "昵称不能为空"
        }
    
        if(self.uploadImg != nil){
            postImg(imageOrVideo: self.uploadImg)
        }
        
        canNext = true
        setLocal(key: "nickName", value: nickName)
    }
    
    func postImg(imageOrVideo : UIImage?){
          print("setMessage")
        
          let headers: HTTPHeaders = [
              "Content-type": "multipart/form-data"
          ]

          AF.upload(
              multipartFormData: { multipartFormData in
                  multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "file.jpeg", mimeType: "image/jpeg")
          },to: "http://127.0.0.1:8080/api/user/uploadImage", method: .post , headers: headers)
              .response { response in
                let res = JSON(response.data)
                let avatar = res["data"].stringValue
                setLocal(key: "avatar", value: avatar)
          }
    }
}

struct userInfoFirst_Previews: PreviewProvider {
    static var previews: some View {
        loginThird()
    }
}
