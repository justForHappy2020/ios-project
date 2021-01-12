//
//  filterItem.swift
//  keepMock1
//
//  Created by 悦月越悦 on 2020/11/15.
import SwiftUI

struct FilterItem: View{
    @Binding var name : String
    @Binding var isChecked: Bool
    
    var body: some View {
        Text(name)
            .foregroundColor(isChecked ? Color.white:boldGreenColor)
            .padding(.vertical,5)
            .padding(.horizontal,15)
            .background(isChecked ? boldGreenColor:Color.white)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .stroke(isChecked ? Color.white:boldGreenColor,lineWidth: 1)
            )
    }
}
