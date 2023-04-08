//
//  CustomTextFieldView.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var searchText: String
    
    var placeholderText: String
    var shadowColor: Color = .accentColor
    var fillColor: Color = Color("lightContainer")
    var leftIcon: Image? = nil
    
    var body: some View {
        HStack {
            if leftIcon != nil {
                leftIcon
                    .foregroundColor(searchText.isEmpty ? .secondary : .primary)
            }
            TextField("\(placeholderText)", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(.primary)
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(searchText.isEmpty ? .secondary : .primary)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    searchText = ""
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(fillColor)
        )
        .padding(.leading)
        .padding(.trailing)
    }
}
