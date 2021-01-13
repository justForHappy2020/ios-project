//
//  Banner.swift
//  keepMock3
//
//  Created by ztwang on 2021/1/13.
//

import SwiftUI

struct Banner: View {
    var body: some View {
        ZStack{
            Image("shareImage")
                .resizable()
                .frame(maxWidth: .infinity,maxHeight:200)
            VStack{
                Text("courseName")
                    .textStyle(.courseName)
            }
        }
    }
}



extension Text {
    
    enum Style {
        case courseName
    }
    
    func textStyle(_ style: Style) -> some View {
        switch style {
        case .courseName:
            return self
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
    }
    
}


struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        let width = UIScreen.main.bounds.width
        Banner()
            .previewLayout(.fixed(width: width, height:300))
    }
    
}
