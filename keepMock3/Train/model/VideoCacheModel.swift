//
//  VideoViewModel.swift
//  Demo
//
//  Created by 悦月越悦 on 2020/12/5.
//

//import Foundation
import Alamofire
import VideoPlayer
import SwiftUI

class VideoCacheModel: ObservableObject{
    
    @Published var actionList : [Action] = []
    @Published var relatedId : Int = 2
    @Published var complete : Bool = false
    @Published var progress: Double = 0.0
    @Published var completeFile: Int = 0
    
    let queue = OperationQueue()
    
    var root : URL{
        return FileManager.default.temporaryDirectory
            .appendingPathComponent(
                    "keepMock",
                    isDirectory: false
            )
            .appendingPathComponent(
                relatedId.description,
                isDirectory: false
            )
    }
    
    
    func fetchActionListAndDownloadVideo(){
        let headers: HTTPHeaders = [
           "Content-Type": "application/json"
       ]
        
        let parameters = [
            "courseId": relatedId,
        ]
        
        let request = AF.request("http://159.75.2.94:8080/api/course/courseId2Course"
                       ,method: .get
                       ,parameters: parameters
                       ,encoding: URLEncoding.default
                       ,headers: headers
                        )
            //该如何使用
        request.responseDecodable(of: responseData<Course1>.self) { (response) in
            print(response)
            guard let res = response.value else { return }

            switch res.status {
                case .success:
                    self.actionList = res.data.actionList
                    self.loadVideoIntoLocal()
                    
                    print("self.actionList=\(self.actionList)")
                    
                case .failed:
                    print("faild")
            }
        }
    }
    
    func creatFilePath(path:String){
        if (IsfileExists(path: path)) {return}
        let fileManager = FileManager.default
        
        do{
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch{
            print("create false")
        }
        
    }
    
    func IsfileExists(path:String) ->Bool{

        let  fileManager = FileManager.default
        let result = fileManager.fileExists(atPath: path)

        if result {
            return true
        }else{
            return false
        }
        
    }
    
    func loadVideoIntoLocal(){
        self.progress = 0
        self.completeFile = 0
        //创建对应的文件目录
        creatFilePath(path: root.path)
        
        //可注释
//        if(IsfileExists(path: root.path)){
//            self.complete = true
//            return
//        }
        //queue
        queue.maxConcurrentOperationCount = 2
        
        for action in actionList {
            let cachedFile = root
                .appendingPathComponent(
                    "action_\(action.actionId).mp4",
                    isDirectory: false
                )
            
            let operation = DownloadOperation(session: URLSession.shared, downloadTaskURL: URL(string: action.actionUrl)!, completionHandler: { (localURL, response, error) in
                do {
                    // Remove any existing document at file
                    if FileManager.default.fileExists(atPath: cachedFile.path) {
                        try FileManager.default.removeItem(at: cachedFile)
                    }
                    
                    // Copy the tempURL to file
                    try FileManager.default.copyItem(
                        at: localURL!,
                        to: cachedFile
                    )
                    print(cachedFile)
                    self.completeFile += 1
                    print("completeFile in videoCacheModel=\(self.completeFile)")
                    DispatchQueue.main.async { [self] in
                        if(self.progress == 1.0){
                            self.complete = true
                        }
                    }
                }
                // Handle potential file system errors
                catch let fileError {
                    print("hasFileError")
                }
            },total:actionList.count, model: self)
            
            queue.addOperation(operation)
            
        }
    }

    //下载类
    class DownloadOperation : Operation {
        
        private var task : URLSessionDownloadTask!
        var observation: NSKeyValueObservation?
        unowned let model: VideoCacheModel = VideoCacheModel()
        
        enum OperationState : Int {
            case ready
            case executing
            case finished
        }
        
        // default state is ready (when the operation is created)
        private var state : OperationState = .ready {
            willSet {
                self.willChangeValue(forKey: "isExecuting")
                self.willChangeValue(forKey: "isFinished")
            }
            
            didSet {
                self.didChangeValue(forKey: "isExecuting")
                self.didChangeValue(forKey: "isFinished")
            }
        }
        
        override var isReady: Bool { return state == .ready }
        override var isExecuting: Bool { return state == .executing }
        override var isFinished: Bool { return state == .finished }
      
        init(session: URLSession, downloadTaskURL: URL,completionHandler: ((URL?, URLResponse?, Error?) -> Void)?,total:Int,model: VideoCacheModel) {
            
            super.init()
            
            // use weak self to prevent retain cycle
            task = session.downloadTask(with: downloadTaskURL, completionHandler: { [weak self] (localURL, response, error) in
                
                /*
                if there is a custom completionHandler defined,
                pass the result gotten in downloadTask's completionHandler to the
                custom completionHandler
                */
                if let completionHandler = completionHandler {
                    // localURL is the temporary URL the downloaded file is located
                    completionHandler(localURL, response, error)
                }
               /*
                 set the operation state to finished once
                 the download task is completed or have error
               */
                self?.state = .finished
            })
            
            observation = task?.progress.observe(\.fractionCompleted){
                observationProgress,_ in
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                DispatchQueue.main.async {
//                    let pastProgress = (1.0/Double(total)) * Double(completeFile)
//                    progress = pastProgress + (1.0/Double(total))*observationProgress.fractionCompleted
//                    print("进度=\(progress)")
//                    print("completeFile=\(completeFile)")
                    let pastProgress = (1.0/Double(total)) * Double(model.completeFile)
                    model.progress = pastProgress + (1.0/Double(total))*observationProgress.fractionCompleted
                    print("进度=\(model.progress)")
                    print("completeFile=\(model.completeFile)")
                }
            }
        }

        override func start() {
        /*
        if the operation or queue got cancelled even
        before the operation has started, set the
        operation state to finished and return
        */
        if(self.isCancelled) {
            state = .finished
            return
        }
        
        // set the state to executing
        state = .executing
        
        print("downloading \(self.task.originalRequest?.url?.absoluteString ?? "")")
            
        // start the downloading
        self.task.resume()
    }

      override func cancel() {
          super.cancel()
          // cancel the downloading
          self.task.cancel()
      }
    }
}




