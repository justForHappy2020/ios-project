//
//  JoinBtn.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct JoinBtn: View {
    var body: some View {
        Text("参加课程")
            .fontWeight(.bold)
            .padding(.vertical,10)
            .frame(maxWidth:.infinity)
            .background(boldGreenColor)
            .foregroundColor(.white)
            .padding(.bottom,20)
    }
}

struct JoinBtn_Previews: PreviewProvider {
    static var previews: some View {
        JoinBtn()
    }
}
