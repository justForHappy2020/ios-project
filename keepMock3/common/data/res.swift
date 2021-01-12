//
//  res.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/10.
//

import Foundation

struct responseData<T>:Decodable where T:Decodable{
    private var code: Int
    var message: String
    var data: T
    var status: Status{
        if code == 200 {
            return .success
        }
        return .failed
    }
    
    enum Status{
        case success
        case failed
    }
}

