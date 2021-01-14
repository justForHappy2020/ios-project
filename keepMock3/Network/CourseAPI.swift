//
//  NetworkAPI.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/13.
//

import Foundation

class CourseAPI {
    
    
    static func fetchCourse(by cid: Int, completion: @escaping (Result <Course, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "course/courseId2Course", parameters: ["courseId" : cid]) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<Course, Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
    

    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Can not parse Data"])
            return .failure(error)
        }
        return .success(decodedData)
    }
}
