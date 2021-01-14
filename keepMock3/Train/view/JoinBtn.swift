//
//  JoinBtn.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct JoinBtn: View {
    
    let text: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("参加课程")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(boldGreenColor)
    }
}

struct JoinBtn_Previews: PreviewProvider {
    static var previews: some View {
        JoinBtn(text: "参加课程", color: .blue) {
            print("Click")
        }
    }
}
