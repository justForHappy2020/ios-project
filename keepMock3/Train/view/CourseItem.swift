//
//  CourseItem.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct CourseItem: View {
    var body: some View {
        Image("shareImage")
            .frame(width: 168, height: 114)
            .clipped()
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem()
    }
}
