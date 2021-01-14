//
//  JoinBtn.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/14.
//

import SwiftUI

struct JoinBtn: View {
    

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("参加课程")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .background(boldGreenColor)
    }
}

struct JoinBtn_Previews: PreviewProvider {
    static var previews: some View {
        JoinBtn {
            print("Click")
        }
    }
}
